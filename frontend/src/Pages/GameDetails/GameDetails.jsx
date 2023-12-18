import * as React from "react";
import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import {
  Rating,
  FormControl,
  Grid,
  TextField,
  Button,
  Paper,
  TableRow,
  TableHead,
  TableContainer,
  TableCell,
  TableBody,
  Table,
  Accordion,
  AccordionSummary,
  AccordionDetails,
  Card,
  CardContent,
  Typography,
} from "@mui/material";
import "./GameDetails.css";

const imgStyle = {
  maxWidth: 300,
};

export default function GameDetails() {
  const { id } = useParams();
  const [boardGame, setBoardGame] = useState(null);
  const [reviewObjects, setReviewObjects] = useState([]);
  const [isAccordionExpanded, setIsAccordionExpanded] = useState(false);
  const [user, setUser] = useState(null);
  const [rating, setRating] = useState(0);
  const handleRatingChange = (event, newValue) => {
    setRating(newValue);
  };

  const userFetch = async () => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
            Authorization: `Bearer ${userToken}`,
            "Content-Type": "application/json",
          }
        : { "Content-Type": "application/json" };

      const response = await fetch(
        `/api/users/${localStorage.getItem("userID")}`,
        {
          method: "GET",
          headers: headers,
        }
      );

      if (response.ok) {
        const data = await response.json();
        setUser(data);
      } else {
        console.error(`Error fetching user data: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching user data: ", error);
    }
  };

  useEffect(() => {
    userFetch();
  }, []);

  const fetchSubmitRating = async () => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = {
        "Content-Type": "application/json",
        Authorization: `Bearer ${userToken}`,
      };

      const sentRating = {};
      sentRating.ratingNumber = rating;
      sentRating.appUserPublicID = localStorage.getItem("userID");
      sentRating.boardGamePublicID = boardGame.publicID;

      const response = await fetch(`/api/ratings`, {
        method: "POST",
        headers: headers,
        body: JSON.stringify(sentRating),
      });

      if (response.ok) {
        return await response.text();
      } else {
        throw new Error(`Error submitting rating: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error submitting rating: ", error);
    }
  };
  const handleSubmitRating = () => {
    fetchSubmitRating();
    setSubmitRating(true);
  }
  

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
        body: JSON.stringify(data.uuid),
      });

      if (response.ok) {
        location.reload();
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

  const fetchRatingForGame = async () => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const userID = localStorage.getItem("userID");
      const boardGamePublicID = boardGame.publicID;
      const headers = userToken
        ? {
            Authorization: `Bearer ${userToken}`,
            "Content-Type": "application/json",
          }
        : { "Content-Type": "application/json" };

      const response = await fetch(
        `/api/ratings/check-existence?appUserPublicID=${userID}&boardGamePublicID=${boardGamePublicID}`,
        {
          method: "GET",
          headers: headers,
        }
      );
      
      if (response.ok) {
        const data = await response.json();
        setCheckedRating(data);
      } else if (response.status === 204) {
        setCheckedRating(null);
      } else {
        console.error(`Error fetching rating: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching rating: ", error);
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

      await Promise.all([fetchReviewsForGame(id), createdReview]);
    } catch (error) {
      console.error("Error creating review: ", error);
    }
  };

  useEffect(() => {
    const fetchGameData = async () => {
      await fetchBoardGame(id);
      await fetchReviewsForGame(id);
    };
  
    fetchGameData();
  }, [id]);
  useEffect(() => {
    if (boardGame) {
      fetchRatingForGame();
    }
  }, [boardGame]);

  const favorizedIDs = user ? user.favoriteBoardGamePublicIDS : [];

  return (
    <div>
      {boardGame && user !== null ? (
        <Card sx={{ maxWidth: 1000 }} style={{ margin: "auto", marginTop: 50 }}>
          <CardContent>
            Categories:
            {boardGame.categories.map((cat) => (
              <Typography
                key={cat.publicID}
                sx={{ fontSize: 14 }}
                color="text.secondary"
                gutterBottom
              >
                {cat.name}
              </Typography>
            ))}
            <div className="flex-container">
              <div className="flex-child magenta">
                <img
                  src="https://potentialplusuk.org/wp-content/uploads/2020/04/game-catan_960.jpg"
                  style={imgStyle}
                  alt="Game"
                />
              </div>
              <div className="flex-child-green">
                <Typography variant="h5">{boardGame.gameName}</Typography>
                <Typography color="textSecondary">
                  {boardGame.description}
                </Typography>
                <br></br>
                {localStorage.getItem("username") ? (
                  !favorizedIDs.includes(boardGame.publicID) ? (
                    <div>
                      <Button onClick={handleAddToFavorites}>
                        Add to favorites
                      </Button>
                      <br></br>
                    </div>
                    : <h4>Boardgame added to your favorites!</h4>
                  : null
                }
                <FormControl>
                        <Typography variant="h6">Rate the game!</Typography>
                        <Rating name="half-rating-read" precision={0.5} value={rating} onChange={handleRatingChange} />
                        <Button variant="contained" color="primary" onClick={() => handleSubmitRating(boardGame.publicID)}>
                          Submit
                        </Button>
                      </FormControl>
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
              <Table
                sx={{ minWidth: 650 }}
                size="small"
                aria-label="a dense table"
              >
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
            {localStorage.getItem("username") ? (
              <Accordion
                expanded={isAccordionExpanded}
                onChange={handleAccordionToggle}
              >
                <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
                >
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
                      <Typography variant="body2">
                        Review by: {review.appUserName}
                      </Typography>
                      <br />
                    </div>
                  ))}
                </AccordionDetails>
              </Accordion>
            ) : null}
          </CardContent>
        </Card>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
}
