import React, { useState } from "react";
import { Button, Form } from "react-bootstrap";
import AddNewTask from "./AddNewTask";
import "../CSS/main.css";
import Card from "./Card";
import { nanoid } from "nanoid";

function Main() {
  const [allTasks, setAllTasks] = useState([]);
  const [newTask, setNewTask] = useState({
    id: nanoid(),
    title: "",
    description: "",
    date: "",
    done: false,
  });

  const handleInputChanges = (event) => {
    const { name, value } = event.target;
    setNewTask({ ...newTask, [name]: value });
  };
  const handleSubmit = (event) => {
    event.preventDefault();

    // Perform any necessary data processing and validation
    // before calling the callback function to add the new task
    setAllTasks((prevState) => [...prevState, newTask]);
    console.log("the submit button is working");
    console.log(newTask);
    console.log("alltasksare:", allTasks);

    setNewTask({
      id: nanoid(),
      title: "",
      description: "",
      date: "",
      done: false,
    });
  };
  const deleteTask = (event, taskId) => {
    console.log("deleted event is:", taskId);
    setAllTasks((prevTasks) => prevTasks.filter((task) => task.id !== taskId));
  };
  return (
    <div className="container-fluid  main">
      {/* Adding a new Task  */}
      <div className="addNewTask row ">
        <h4 className="text-center addNewTask__title">Add a new task</h4>

        <Form onSubmit={handleSubmit} className="row">
          <div className="row mt-2">
            <div className="col-8">
              <Form.Group controlId="formTaskText">
                {/* <Form.Label>Title</Form.Label> */}
                <Form.Control
                  name="title"
                  type="text"
                  value={newTask.title}
                  onChange={handleInputChanges}
                  required
                  placeholder="Title"
                />
              </Form.Group>
            </div>

            <div className="col-2">
              <Form.Group controlId="formTaskDate">
                {/* <Form.Label>Due Date</Form.Label> */}
                <Form.Control
                  name="date"
                  type="date"
                  value={newTask.date}
                  onChange={handleInputChanges}
                  required
                />
              </Form.Group>
            </div>
            <div className="col-2">
              <Button
                variant="primary"
                onClick={handleSubmit}
                className=" btn "
              >
                Add Task
              </Button>
            </div>
          </div>
          <div className="row mt-3">
            <div className="col">
              <Form.Group controlId="formTaskText">
                {/* <Form.Label>Description</Form.Label> */}
                <Form.Control
                  name="description"
                  type="text"
                  value={newTask.description}
                  onChange={handleInputChanges}
                  required
                  placeholder="Description"
                />
              </Form.Group>
            </div>
          </div>
        </Form>
      </div>

      <div className="row mt-5">
        <div className="col-md-4-  toDoList p-2 ">
          {allTasks.reverse().map((task) => (
            <Card
              key={task.id}
              id={task.id}
              title={task.title}
              description={task.description}
              date={task.date}
              deleteTask={deleteTask}
            />
          ))}

          {/* <Card
            title="Card Title 1"
            description="Card Description 1"
            date="2022-03-01"
          />
          <Card
            title="Card Title 1"
            description="Card Description 1"
            date="2022-03-01"
          />
          <Card
            title="Card Title 1"
            description="Card Description 1"
            date="2022-03-01"
          /> */}
        </div>
        {/* <div className="col-md-4 border">
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
        </div> */}
      </div>
    </div>
  );
}

export default Main;
