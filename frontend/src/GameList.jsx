import React, { useEffect, useState } from 'react';

const GameList = () => {

    const [games, setGames] = useState([]);
    const [loading, setLoading] = useState(false);


const gamesFetch = async () => {
  try {
    const response = await fetch("/api/games");
    const data = await response.json();
    setGames(data);
    setLoading(false);
  } catch (error) {
    console.error(error);
  }
}

  
    useEffect(() => {
      gamesFetch();
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


  return (
    <div>
      <table>
        <thead>
    <tr>
      <th>
        Name
      </th>
    </tr>
        </thead>
        <tbody>
        {games.map((game) => (
         <tr key={game.id}>
           <td>{game.gameName}</td>
         </tr>
  ))}
        </tbody>
      </table>
    </div>
  );
};

export default GameList;