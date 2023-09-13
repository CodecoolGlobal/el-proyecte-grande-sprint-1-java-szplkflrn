import './App.css';
import React, { useState } from 'react';
import GameList from './GameList';

function App() {
  const [showGameList, setShowGameList] = useState(false);

  const handleButtonClick = () => {
    setShowGameList(!showGameList);
  };

  return (
    <>
      <h1>Welcome</h1>
      <div className="card">
        <button onClick={handleButtonClick}>
          Lets see all of the board games
        </button>
      </div>
       <GameList />
    </>
  );
}

export default App;
