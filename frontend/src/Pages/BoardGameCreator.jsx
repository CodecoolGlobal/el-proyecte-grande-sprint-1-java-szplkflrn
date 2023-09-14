import { useState } from "react";
import { useNavigate } from "react-router-dom";
import BoardGameForm from "../Components/BoardGameForm";


const createGame = async (boardGame) => {
  const res = await fetch("/api/newGame", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(boardGame),
    });
    return await res.json();
};


const BoardGameCreator = () => {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(false);
  
    const handleCreateBoardGame = (boardGame) => {
      setLoading(true);
  
      createGame(boardGame)
        .then(() => {
          setLoading(false);
          navigate("/games");
        })
    };
  
    return (
      <BoardGameForm
        onCancel={() => navigate("/")}
        disabled={loading}
        onSave={handleCreateBoardGame}
      />
    );
} 

export default BoardGameCreator