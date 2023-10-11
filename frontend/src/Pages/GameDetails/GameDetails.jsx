import * as React from 'react';
import { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
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


const fetchBoardGame = async (id) => {
  const res = await fetch(`/api/games/${id}`);
  return await res.json();
};

export default function GameDetails() {
  const { id } = useParams();
  const [boardGame, setBoardGame] = useState(null);


  useEffect(() => {
    fetchBoardGame(id)
      .then((boardgame) => {
        setBoardGame(boardgame);
      });
  }, [id]);




  return (<div>
    <Card sx={{ maxWidth: 1000 }} style={{
      margin: "auto",
      marginTop: 50
    }}>
      <CardContent>

        <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
          boardgame categories
        </Typography>
        <div class="flex-container">

          <div class="flex-child magenta">
            <img src='https://potentialplusuk.org/wp-content/uploads/2020/04/game-catan_960.jpg' style={imgStyle} />
          </div>

          <div class="flex-child-green">
            <Typography variant="h5" textAlign={'right'}>
              NAME OF THE ****GAME
            </Typography>
            <Typography color="textSecondary" >
              Description
            </Typography>
          </div>
        </div>
        <br></br>
        <br></br>
        <Typography variant="body2">
          Details of the game
          <br />
          <br></br>

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
                    minPlayer
                  </TableCell>
                  <TableCell>maxplayer</TableCell>
                  <TableCell>time</TableCell>
                  <TableCell>age</TableCell>
                </TableRow>
              </TableBody>
            </Table>
          </TableContainer>
          <br>
          </br>
          
          <Accordion>
            <AccordionSummary
              expandIcon={<ExpandMoreIcon />}
              aria-controls="panel1a-content"
              id="panel1a-header"
            >
              <Typography>Reviews</Typography>
            </AccordionSummary>
            <AccordionDetails>
              <Typography>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
                malesuada lacus ex, sit amet blandit leo lobortis eget.
              </Typography>
            </AccordionDetails>
          </Accordion>

          
        </Typography>
      </CardContent>
    </Card>
  </div>
  );
}



