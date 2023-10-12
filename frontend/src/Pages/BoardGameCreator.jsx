import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import BoardGameForm from "../Components/BoardGameForm";

const BoardGameCreator = () => {
  const [games, setGames] = useState([]);
    const navigate = useNavigate();


    const createGame = async (boardGame) => {
      try {
        const userToken = localStorage.getItem("usertoken");
        const headers = {
          "Content-Type": "application/json",
          Authorization: `Bearer ${userToken}`,
        };
    
        const res = await fetch("/api/games", {
          method: "POST",
          headers: headers,
          body: JSON.stringify(boardGame),
        });
    
        if (res.ok) {
          return await res.text();
        } else {
          throw new Error(`Error creating game: ${res.statusText}`);
        }
      } catch (error) {
        console.error("Error creating game: ", error);
        throw error;
      }
    };
    


    const gamesFetch = async () => {
      try {
        const userToken = localStorage.getItem("usertoken");
        const headers = userToken
          ? {
              Authorization: `Bearer ${userToken}`,
              "Content-Type": "application/json",
            }
          : { "Content-Type": "application/json" };
    
        const response = await fetch("/api/games", {
          method: "GET",
          headers: headers,
        });
    
        if (response.ok) {
          const data = await response.json();
          setGames(data);
        } else {
          console.error(`Error fetching games: ${response.statusText}`);
        }
      } catch (error) {
        console.error("Error fetching games: ", error);
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