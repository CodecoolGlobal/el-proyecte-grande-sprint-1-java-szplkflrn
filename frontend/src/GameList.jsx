import React, { useEffect, useState } from 'react';

const GameList = () => {

    const [games, setGames] = useState([]);
    const [loading, setLoading] = useState(false);
  
    useEffect(() => {
      setLoading(false);
  
      fetch('/games')
        .then(response => response.json())
        .then(data => {
          setGames(data);
          setLoading(false);
        })
    }, []);

  const remove = async (id) => {
    await fetch(`/${id}`, {
      method: 'DELETE',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).then(() => {
      let updatedGames = [...games].filter(i => i.id !== id);
      setGames(updatedGames);
    });
  }

  if (loading) {
    return <p>Loading...</p>;
  }

  const gameList = games.map(game => {
    <div key={game.id}>
      {game.name}
    </div>
  });

  return (
    <div>
      <h1>ITT A LISTA</h1>
          {gameList}
    </div>
  );
};

export default GameList;