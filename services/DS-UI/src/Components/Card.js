import React, { useState } from "react";
import { BsFillTrash3Fill, BsPencil } from "react-icons/bs";
import "../CSS/card.css";

const Card = (props) => {
  const [done, setDone] = useState(false);
  const handleToggle = () => {
    setDone((prevDone) => {
      props.toggleIsDone(props.id, !prevDone);
      return !prevDone;
    });
  };

  return (
    <div className={done ? "card mt-4 px-4 done" : "card mt-4 px-4"}>
      <div
        className="card-body row justify-content-center align-items-center "
        key={props.id}
      >
        <div className="form-check col-1">
          <input
            type="checkbox"
            className="form-check-input"
            // name={`radio${props.id}`}
            // id={`radio${props.id}`}
            checked={done}
            onChange={handleToggle}
          />
          <label className="form-check-label"></label>
        </div>

        <div className="col">
          <h5 className="card-title fw-bolder fs-3 ">
            {done ? <s>{props.title}</s> : props.title}
          </h5>

          <p className="card-text">
            {done ? <s>{props.description}</s> : props.description}
          </p>

          <p className="card-text">{done ? <s>{props.date}</s> : props.date}</p>
        </div>
        <div className=" col-1 d-flex icons-container justify-content-end align-items-center">
          {/* <a href="#" className="p-2 editIcon">
            <BsPencil className="icons" />
          </a> */}
          <a
            href="#"
            className="deleteIcon"
            onClick={(event) => props.deleteTask(event, props.id)}
          >
            <BsFillTrash3Fill className="icons " />
          </a>
        </div>
      </div>
    </div>
  );
};

export default Card;
