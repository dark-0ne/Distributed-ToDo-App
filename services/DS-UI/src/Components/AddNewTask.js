import React, { useState } from "react";
import { Button, Modal, Form } from "react-bootstrap";
import SideBar from "./SideBar";

function AddNewTask(props) {
  // The modal is coming from the Sidebar
  // const [showModal, setShowModal] = useState("false");
  // const [modal, toggleModal] = props;
  // console.log(props);
  const [newTask, setNewTask] = useState({
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

    console.log("the submit button is working");
    console.log(newTask);

    setNewTask({ title: "", description: "", date: "" });

    props.toggleModal();
  };
  const cancelModal = () => {
    console.log("cancel buttom is working");
    props.toggleModal();
  };

  return (
    <>
      {/* <Button variant="primary" onClick={() => setShowModal(true)}>
        Add New Task
      </Button> */}

      {/* <Modal show={showModal} onHide={() => setShowModal(false)}> */}
      <Modal show={props.showModal}>
        <Modal.Header>
          <Modal.Title>Add New Task</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form onSubmit={handleSubmit}>
            <Form.Group controlId="formTaskText">
              <Form.Label>Title</Form.Label>
              <Form.Control
                name="title"
                type="text"
                value={newTask.title}
                onChange={handleInputChanges}
                required
              />
            </Form.Group>

            <Form.Group controlId="formTaskText">
              <Form.Label>Description</Form.Label>
              <Form.Control
                name="description"
                type="text"
                value={newTask.description}
                onChange={handleInputChanges}
                required
              />
            </Form.Group>

            <Form.Group controlId="formTaskDate">
              <Form.Label>Due Date</Form.Label>
              <Form.Control
                name="date"
                type="date"
                value={newTask.date}
                onChange={handleInputChanges}
                required
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={cancelModal}>
            Cancel
          </Button>
          <Button variant="primary" onClick={handleSubmit}>
            Add Task
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default AddNewTask;
