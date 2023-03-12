import "./App.css";
import SideBar from "./Components/SideBar";
import Main from "./Components/Main";

function App() {
  return (
    <div className="App container-fluid">
      <div className="">
        <Main />
        {/* <div className="col-md-2 col-12">
          <SideBar />
        </div>
        <div className="col-md-10 col-12">
          <Main />
        </div> */}
      </div>
    </div>
  );
}

export default App;
