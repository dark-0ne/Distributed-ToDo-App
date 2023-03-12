#!/bin/python3

import sys
import os
import time
import datetime
import logging
import socket
from optparse import OptionParser
from statistics import mean

from pymongo import MongoClient
from dotenv import load_dotenv


_name = 'mongodb_stress_test'
_file_name = '_'.join([_name, datetime.datetime.now().strftime(
    "%Y-%m-%d-%H-%M-%S-%f") + '.log'])

log = logging.getLogger(__name__)
hdlr = logging.FileHandler(os.path.join(
    os.environ['HOME'], 'test_scripts', 'logs', _file_name))
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
hdlr.setFormatter(formatter)
log.addHandler(hdlr)
log.setLevel(logging.DEBUG)


DB_NAME = 'todo-app'
COLLECTION_NAME = 'users'


def mongo_inserter(cid, ndocs, host, port):

    s = socket.getfqdn()
    log.info("inserter.start client={i} node={n} server={h}:{p}".format(
             i=cid, n=s, h=host, p=port))
    conn = MongoClient(host, port)
    db = conn[DB_NAME]
    collection = db[COLLECTION_NAME]
    insert_times = []
    for n in range(ndocs):
        message = "updating mongodb with value {v} from client {i}".format(
            v=n, i=cid)
        #log.info(message)
        doc = {}
        t0 = time.time()
        collection.insert_one(doc)
        tf = time.time()
        insert_times.append(tf - t0)

    avg_insert_time = mean(insert_times)
    m = "Client {i} took {dt} with op/s {o:2f}".format(
        i=cid, dt=sum(insert_times), o=avg_insert_time/ndocs)
    log.info(m)


def main(nclients, ndocs, host, port):
    log.info(
        "Starting Main with {n} workers and inserting {m} docs each".format(
            n=nclients, m=ndocs))

    pids = {}
    for n in range(nclients):
        pid = os.fork()
        pids[n] = pid

        if pid == 0:
            log.debug("forking process {n}:{i}".format(n=n, i=pid))
            mongo_inserter(n, ndocs, host, port)
            os._exit(0)

    # wait for children to complete
    os.waitpid(-1, 0)
    print("completed!")
    return 0


if __name__ == '__main__':
    load_dotenv()
    parser = OptionParser()
    parser.add_option(
        '-n', '--nclients', type='int', dest='nclients',
        help='Number of clients to start up')
    parser.add_option(
        '-d', '--ndocs', dest='ndocs', type='int', default=1000,
        help='number of docs to import per client into the db')
    (options, args) = parser.parse_args()

    # nclients, host must be given!
    if options.nclients is not None:
        sys.exit(
            main(
                options.nclients, options.ndocs,
                ["mongodb-router-0", "mongodb-router-1", "mongodb-router-2"],
                16985))
    else:
        print("Provide --nclients")
        sys.exit(0)
