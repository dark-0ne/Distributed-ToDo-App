import React from "react";
import { BsFillTrash3Fill, BsPencil } from "react-icons/bs";
import "../CSS/card.css";

const Card = (props) => {
  return (
    <div className="card">
      <div className="card-body">
        <h5 className="card-title">{props.title}</h5>
        <p className="card-text">{props.description}</p>
        <p className="card-text">{props.date}</p>
        <div className="icons-container">
          <a href="#" className=" btn">
            <BsFillTrash3Fill />
          </a>
          <a href="#" className="btn">
            <BsPencil />
          </a>
        </div>
      </div>
    </div>
  );
};

export default Card;
