import React, { useState } from "react";
import AddNewTask from "./AddNewTask";
import "../CSS/main.css";
import Card from "./Card";

function Main() {
  return (
    // <div className="main  ">
    //   <div className="row gx-3">
    //     <div className="col  ">
    //       <div className="main-col p-3">erwerw</div>
    //     </div>
    //     <div className="col  ">
    //       <div className="main-col p-3">erwerw</div>
    //     </div>
    //     <div className="col  ">
    //       <div className="main-col p-3">erwerw</div>
    //     </div>
    //   </div>
    // </div>

    <div className="container-fluid">
      <div className="row">
        <div className="col-md-4 border">
          <h4>Today's</h4>
          <Card
            title="Card Title 1"
            description="Card Description 1"
            date="2022-03-01"
          />
        </div>
        <div className="col-md-4 border">
          <h4>Tomorrow's</h4>
          <Card
            title="Card Title 2"
            description="Card Description 2"
            date="2022-03-02"
          />
        </div>
        <div className="col-md-4 border">
          <h4>UpComing Events</h4>
          <Card
            title="Card Title 3"
            description="Card Description 3"
            date="2022-03-03"
          />
        </div>
      </div>
    </div>
  );
}

export default Main;
