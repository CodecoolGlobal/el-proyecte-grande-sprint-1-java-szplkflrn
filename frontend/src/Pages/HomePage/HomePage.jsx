import { Button } from '@mui/material';
import './HomePage.css';
import { Link } from "react-router-dom";

function App() {
  return (
    <div className='home-page'>
      <h1>Welcome in ByteBattlers</h1>
      {!localStorage.getItem("username") ?
      <div className="card">
        <Button>
          <Link to="/login">Login</Link>
        </Button>
        <Button>
        <Link to="/games/register">Register</Link>
        </Button>
        </div>
      : <></>
    }
    </div>
  );
}

export default App;
