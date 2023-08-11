#!/bin/python3
import sys
import os
import time
import datetime
import logging
import socket
import random
import string
import requests
from optparse import OptionParser
from statistics import mean
from multiprocessing import Process, Manager

from dotenv import load_dotenv
from faker import Faker


_name = 'flask_stress_test'
_file_name = '_'.join([_name, datetime.datetime.now().strftime(
    "%Y-%m-%d-%H-%M-%S-%f") + '.log'])

log = logging.getLogger(__name__)
hdlr = logging.FileHandler(os.path.join(
    os.environ['HOME'], 'test_scripts', 'logs', _file_name))
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
hdlr.setFormatter(formatter)
log.addHandler(hdlr)
log.setLevel(logging.DEBUG)

letters = string.ascii_lowercase

url = "https://nginx-0/api/tasks/"


def flask_inserter(cid, ndocs, avg_times):

    s = socket.getfqdn()
    insert_times = []
    fake = Faker()
    for n in range(ndocs):
        #log.info(message)
        payload = json.dumps({
            "title": "".join(
                random.choices(letters, k=random.randint(10, 32))),
            "description": "".join(
                random.choices(letters, k=random.randint(20, 256))),
            "completed": random.choice((True, False)),
            "created_at": fake.date_time_this_year()})
        headers = {
            'Content-Type': 'application/json'
        }

        t0 = time.time()
        response = requests.request("POST", url, headers=headers, data=payload)
        tf = time.time()
        insert_times.append(tf - t0)

    avg_insert_time = mean(insert_times)
    avg_times.append(avg_insert_time)
    m = "Client {i} took {dt} with op/s {o:2f}".format(
        i=cid, dt=sum(insert_times), o=avg_insert_time)
    log.info(m)


def main(nclients, ndocs):

    with Manager() as manager:
        avg_times = manager.list()
        processes = []

        t0 = time.time()
        for n in range(nclients):
            p = Process(target=flask_inserter, args=(
                n, ndocs, avg_times))
            p.start()
            processes.append(p)

        for p in processes:
            p.join()

        tf = time.time()
        dt = tf - t0
        print("completed!")
        m = "Insertion took {dt} seconds with {o:2f} operations/s.".format(
            dt=dt, o=(ndocs*nclients)/dt)
        log.info(m)
        m = "Each client took {o:2f} seconds on average to complete.".format(
            o=mean(avg_times))
        log.info(m)
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
                options.nclients, options.ndocs))
    else:
        print("Provide --nclients")
        sys.exit(0)
