import * as React from 'react';
import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import {
  Grid, TextField, Button, Paper, TableRow,
  TableHead, TableContainer, TableCell, TableBody, Table,
  Accordion, AccordionSummary, AccordionDetails, Card, CardContent, Typography
} from '@mui/material';
import "./GameDetails.css";

const imgStyle = {
  maxWidth: 300
}

export default function GameDetails() {
  const { id } = useParams();
  const [boardGame, setBoardGame] = useState(null);
  const [reviewObjects, setReviewObjects] = useState([]);
  const [isAccordionExpanded, setIsAccordionExpanded] = useState(false);
  const [user, setUser] = useState(null);
 

  const userFetch = async () => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const response = await fetch(`/api/users/${localStorage.getItem("userID")}`, {
        method: "GET",
        headers: headers,
      });

      if (response.ok) {
        const data = await response.json();
        setUser(data);
      } else {
        console.error(`Error fetching user data: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching user data: ", error);
    }
  }

  useEffect(() => {
    userFetch();
  }, []);





  const handleAccordionToggle = () => {
    setIsAccordionExpanded(!isAccordionExpanded);
  };

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


  const handleAddToFavorites = async () => {
    const userId = localStorage.getItem("userID");
    const uuid = boardGame.publicID;

    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const data = {
        uuid
      };



      const response = await fetch(`/api/users/${userId}`, {
        method: "PATCH",
        headers: headers,
        body: JSON.stringify(data.uuid)
      });

      if (response.ok) {
        location.reload()
      } else {
        throw new Error("Update user failed");
      }
    } catch (error) {
      console.error("Error updating user: ", error);
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

  const onSubmit = async (e) => {
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

    review.appUserPublicID = localStorage.getItem("userID");
    review.boardGamePublicID = boardGame.publicID;
    e.target.reset();

    try {
      const createdReview = await createReview(review);
      setIsAccordionExpanded(false);

      // Wait for the review creation to complete and then fetch the updated reviews
      await Promise.all([fetchReviewsForGame(id), createdReview]);

    } catch (error) {
      console.error("Error creating review: ", error);
    }
  };

  useEffect(() => {
    fetchBoardGame(id);
    fetchReviewsForGame(id);
  }, [id]);


  const favorizedIDs = user ? user.favoriteBoardGamePublicIDS : [];

  return (
    <div>
      {boardGame ? (
        <Card sx={{ maxWidth: 1000 }} style={{ margin: "auto", marginTop: 50 }}>
          <CardContent>
            Categories:
            {boardGame.categories.map((cat) => (
              <Typography key={cat.publicID} sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
                {cat.name}
              </Typography>
            ))}

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
            </Typography>

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
              <Accordion expanded={isAccordionExpanded} onChange={handleAccordionToggle}>
              <AccordionSummary expandIcon={<ExpandMoreIcon />} aria-controls="panel1a-content" id="panel1a-header">
                <Typography variant="h6">Write Review</Typography>
              </AccordionSummary>
              <AccordionDetails>
                <div className="reviewForm">
                  <form className="reviewForm" onSubmit={onSubmit}>
                    <Grid container spacing={2}>
                      <Grid item xs={12}>
                        <TextField
                          fullWidth
                          variant="outlined"
                          label="Review"
                          name="description"
                          id="description"
                        />
                      </Grid>
                      <Grid item xs={12}>
                        <Button type="submit" variant="contained" color="primary">
                          Add review
                        </Button>
                      </Grid>
                    </Grid>
                  </form>
                </div>
              </AccordionDetails>
            </Accordion>
              : null}
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
                  {reviewObjects.map((review) => (
                    <div key={review.publicID}>
                      <Typography variant="h6">{review.description}</Typography>
                      <Typography variant="body2">Review by: {review.appUserName}</Typography>
                      <br />
                    </div>
                  ))}
                </AccordionDetails>
              </Accordion> : null
            }
          </CardContent>
        </Card>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
}
