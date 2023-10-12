import * as React from 'react';
import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import "./GameDetails.css";


const imgStyle = {
  maxWidth: 300
}


export default function GameDetails() {
  const { id } = useParams();
  const [boardGame, setBoardGame] = useState(null);
  const [reviewObjects, setReviewObjects] = useState([]);


  const createReview = async (review) => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${userToken}`,
      };

      const res = await fetch("/api/reviews", {
        method: "POST",
        headers: headers,
        body: JSON.stringify(review),
      });

      if (res.ok) {
        return await res.text();
      } else {
        throw new Error(`Error creating review: ${res.statusText}`);
      }
    } catch (error) {
      console.error("Error creating review: ", error);
      throw error;
    }
  };


  const fetchReviewsForGame = async (id) => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const response = await fetch(`/api/reviews/${id}`, {
        method: "GET",
        headers: headers,
      });
      if (response.ok) {
        const data = await response.json();
        setReviewObjects(data);
      } else {
        console.error(`Error fetching reviews: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching reviews: ", error);
    }
  };


  const fetchBoardGame = async (id) => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const response = await fetch(`/api/games/${id}`, {
        method: "GET",
        headers: headers,
      });
      if (response.ok) {
        const data = await response.json();
        setBoardGame(data);
      } else {
        console.error(`Error fetching games: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching game: ", error);
    }
  };


  const onSubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const entries = [...formData.entries()];

    const isAnyFieldEmpty = entries.some(([, v]) => !v);

    if (isAnyFieldEmpty) {
      alert("Please fill in all the fields");
      return;
    }

    const review = entries.reduce((acc, entry) => {
      const [k, v] = entry;
      acc[k] = v;
      return acc;
    }, {});

    review.appUserPublicID = localStorage.getItem("userID")
    review.boardGamePublicID = boardGame.publicID

    createReview(review)
  };


  useEffect(() => {
    fetchBoardGame(id)
    fetchReviewsForGame(id);
  }, [id]);

  console.log(reviewObjects)

  return (
    <div>
      {boardGame ? (
        <Card sx={{ maxWidth: 1000 }} style={{ margin: "auto", marginTop: 50 }}>
          <CardContent>
            {boardGame.categories.map((game) => {
              return <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>{game.name}</Typography>
            })}
            <div className="flex-container">
              <div className="flex-child magenta">
                <img src='https://potentialplusuk.org/wp-content/uploads/2020/04/game-catan_960.jpg' style={imgStyle} alt="Game" />
              </div>
              <div className="flex-child-green">
                <Typography variant="h5">
                  {boardGame.gameName}
                </Typography>
                <Typography color="textSecondary">
                  {boardGame.description}
                </Typography>
              </div>
            </div>
            <br />
            <br />
            <Typography variant="body2">
              Details of the game
              <br />
              <br />
              <TableContainer component={Paper}>
                <Table sx={{ minWidth: 650 }} size="small" aria-label="a dense table">
                  <TableHead>
                    <TableRow>
                      <TableCell>Min Player</TableCell>
                      <TableCell>Max Player</TableCell>
                      <TableCell>Playing Time</TableCell>
                      <TableCell>Age</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    <TableRow>
                      <TableCell component="th" scope="row">
                        {boardGame.minPlayer}
                      </TableCell>
                      <TableCell>{boardGame.maxPlayer}</TableCell>
                      <TableCell>{boardGame.playTimeInMinutes}</TableCell>
                      <TableCell>{boardGame.recommendedAge}</TableCell>
                    </TableRow>
                  </TableBody>
                </Table>
              </TableContainer>
              <br />
              {localStorage.getItem("username") ?
                <Accordion>
                  <AccordionSummary
                    expandIcon={<ExpandMoreIcon />}
                    aria-controls="panel1a-content"
                    id="panel1a-header"
                  >
                    <h3>Write Review</h3>
                  </AccordionSummary>
                  <AccordionDetails>
                    <div className="reviewForm">
                      <form className="reviewForm" onSubmit={onSubmit}>

                        <br></br>
                        <div className="control">
                          <label htmlFor="description">Review: </label>
                          <input
                            name="description"
                            id="description"
                          />
                        </div>

                        <div className="buttons">
                          <button type="submit">
                            Add review
                          </button>
                        </div>
                        <br></br>
                      </form>
                    </div>

                  </AccordionDetails>
                </Accordion>
                : null
              }

              {boardGame.reviews.length ?
                <Accordion>
                  <AccordionSummary
                    expandIcon={<ExpandMoreIcon />}
                    aria-controls="panel1a-content"
                    id="panel1a-header"
                  >
                    <h3>Reviews</h3>
                  </AccordionSummary>
                  <AccordionDetails>
                    {reviewObjects.map((review) => {
                      return <div><h2>{review.description}</h2><p>Review by: {review.appUserPublicID}</p><br></br></div>
                    })}
                  </AccordionDetails>
                </Accordion> : null
              }
            </Typography>
          </CardContent>
        </Card>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
}



