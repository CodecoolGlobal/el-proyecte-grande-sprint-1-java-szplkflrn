import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import BoardGameForm from "../Components/BoardGameForm";

const BoardGameCreator = () => {
  const [games, setGames] = useState([]);
    const navigate = useNavigate();


    const createGame =  async (boardGame) => {
      const res = await fetch("/api/games", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(boardGame),
      });
     
      return await res.text()
    };


    const gamesFetch = async () => {
      try {
        const response = await fetch("/api/games");
        const data = await response.json();
        setGames(data);
      } catch (error) {
        console.error(error);
      }
    };
    
    useEffect(() => {
      gamesFetch();
    }, []);
  
    const handleCreateBoardGame = (boardGame) => {
      let gameExists = false;
      for (let i = 0; i < games.length; i++) {
        if (boardGame.gameName === games[i].gameName) {
          gameExists = true;
          break;
        }
      }
    
      if (gameExists) {
        alert("This game already exists!");
      } else {
        createGame(boardGame)
          .then(() => {
            navigate("/games");
          })
          .catch((error) => {
            console.error("Error creating game:", error);
          });
      }
    };
    
  
    return (
      <BoardGameForm
        onCancel={() => navigate("/")}
        onSave={handleCreateBoardGame}
      />
    );
} 

export default BoardGameCreator