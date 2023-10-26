import React, { useEffect, useState } from 'react';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import {
  Link, Accordion, AccordionSummary, AccordionDetails, Card, CardContent, Typography, Button
} from '@mui/material';

function UserFavoritesSite() {
  const [user, setUser] = useState(null);
  const [bgs, setBgs] = useState(null);


  const removeBoardGameFromFavorites = async (userId, boardGameId) => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const data = {
        boardGameId
      }

      const response = await fetch(`/api/users/favorites/${userId}`, {
        method: "DELETE",
        headers: headers,
        body: JSON.stringify(data.boardGameId)
      });

      if (response.ok) {
        // Board game was successfully removed from favorites
        // You can update the UI or display a message here
        console.log('Board game removed from favorites');
        location.reload();
      } else {
        console.error(`Error removing board game from favorites: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error removing board game from favorites: ", error);
    }
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

  useEffect(() => {
    if (user) {
      favBoardGamesFetch();
    }
  }, [user]);

  const favBoardGamesFetch = async () => {
    const uuids = user.favoriteBoardGamePublicIDS;

    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };

      const data = {
        uuids
      };

      const response = await fetch(`/api/games/myfavorites`, {
        method: "POST",
        headers: headers,
        body: JSON.stringify(data.uuids),
      });

      if (response.ok) {
        const games = await response.json();
        setBgs(games);
      } else {
        console.error(`Error fetching user data: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching user data: ", error);
    }
  }
  return (
    <div>
      {user !== null && bgs !== null ? (
        <Card sx={{ maxWidth: 1000 }} style={{ margin: "auto", marginTop: 50 }}>
          <CardContent>
            {user.favoriteBoardGamePublicIDS.length !== 0 ?
              <Typography textAlign={"center"} style={{ fontWeight: "bold" }}>Your Favorite Boardgames:</Typography>
              : <div style={{ textAlign: "center" }}>
                <Typography textAlign={"center"} style={{ fontWeight: "bold" }}>You don't have any favorite Boardgames!</Typography>
                <Button href="/games">Jump to the Games!</Button>
              </div>
            }
            <br />

            {bgs.map((bg) => (

              <Accordion key={bg.publicID}>

                <AccordionSummary>
                  <Link border={"none"} href={`/games/${bg.publicID}`}>
                    {bg.gameName}
                  </Link>
                  <Typography margin={"auto"}>Click to see your reviews!</Typography>
                  <Button onClick={() => removeBoardGameFromFavorites(localStorage.getItem("userID"), bg.publicID)}>Delete from favorites</Button>
                </AccordionSummary>
                <AccordionDetails>

                  {user.reviews.map((userRev) => {
                    return bg.reviews.map((bgRev) => {
                      if (userRev.publicID === bgRev.publicID) {

                        return (
                          <div key={bgRev.publicID}>
                            <Typography variant="body2">Review:</Typography>
                            <Typography variant="h6">{bgRev.description}</Typography>
                            <br></br>
                          </div>
                        );
                      }
                      return; // Return null if there's no matching review
                    });
                  })}
                </AccordionDetails>
              </Accordion>
            ))}
          </CardContent>
        </Card>
      ) : (
        <div>Loading...</div>
      )}
    </div>
  );
}

export default UserFavoritesSite;
