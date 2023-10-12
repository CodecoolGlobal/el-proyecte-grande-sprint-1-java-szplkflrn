import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import { useTheme } from "@mui/material/styles";
import Box from "@mui/material/Box";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableFooter from "@mui/material/TableFooter";
import TablePagination from "@mui/material/TablePagination";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import IconButton from "@mui/material/IconButton";
import FirstPageIcon from "@mui/icons-material/FirstPage";
import KeyboardArrowLeft from "@mui/icons-material/KeyboardArrowLeft";
import KeyboardArrowRight from "@mui/icons-material/KeyboardArrowRight";
import LastPageIcon from "@mui/icons-material/LastPage";
import { Link } from "@mui/material";

function TablePaginationActions(props) {
  const theme = useTheme();
  const { count, page, rowsPerPage, onPageChange } = props;

  const handleFirstPageButtonClick = (event) => {
    onPageChange(event, 0);
  };

  const handleBackButtonClick = (event) => {
    onPageChange(event, page - 1);
  };

  const handleNextButtonClick = (event) => {
    onPageChange(event, page + 1);
  };

  const handleLastPageButtonClick = (event) => {
    onPageChange(event, Math.max(0, Math.ceil(count / rowsPerPage) - 1));
  };

  return (
    <Box sx={{ flexShrink: 0, ml: 2.5 }}>
      <IconButton
        onClick={handleFirstPageButtonClick}
        disabled={page === 0}
        aria-label="first page"
      >
        {theme.direction === "rtl" ? <LastPageIcon /> : <FirstPageIcon />}
      </IconButton>
      <IconButton
        onClick={handleBackButtonClick}
        disabled={page === 0}
        aria-label="previous page"
      >
        {theme.direction === "rtl" ? (
          <KeyboardArrowRight />
        ) : (
          <KeyboardArrowLeft />
        )}
      </IconButton>
      <IconButton
        onClick={handleNextButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="next page"
      >
        {theme.direction === "rtl" ? (
          <KeyboardArrowLeft />
        ) : (
          <KeyboardArrowRight />
        )}
      </IconButton>
      <IconButton
        onClick={handleLastPageButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="last pasge"
      >
        {theme.direction === "rtl" ? <FirstPageIcon /> : <LastPageIcon />}
      </IconButton>
    </Box>
  );
}

TablePaginationActions.propTypes = {
  count: PropTypes.number.isRequired,
  onPageChange: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
  rowsPerPage: PropTypes.number.isRequired,
};

export default function GameList() {
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [games, setGames] = useState([]);
  const [update, setUpdate] = useState(0);
  const [message, setMessage] = useState("");

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

  function createData(
    publicID,
    name,
    minplayer,
    maxplayer,
    description,
    publisherPublisherName,
    categories,
    rating,
    reviews
  ) {
    return {
      publicID,
      name,
      minplayer,
      maxplayer,
      description,
      publisherPublisherName,
      categories,
      rating,
      reviews,
    };
  }

  const rows = games.map((game) => {
    return createData(
      game.publicID,
      game.gameName,
      game.minPlayer,
      game.maxPlayer,
      game.description,
      game.publisherPublisherName,
      game.categories,
      game.rating,
      game.reviews
    );
  });

  const emptyRows =
    page > 0 ? Math.max(0, (1 + page) * rowsPerPage - rows.length) : 0;

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };


  const startIndex = page * rowsPerPage;
  const endIndex = startIndex + rowsPerPage;
  const displayedRows = rows.slice(startIndex, endIndex);

  return (
    <>
      <div>
        <br />
        <br />
        <TableContainer
          component={Paper}
          sx={{ maxWidth: 1000, margin: "auto", opacity: 0.9 }}
          align="center"
        >
          <Table sx={{ minWidth: 500 }} aria-label="custom pagination table">
            <TableHead>
              <TableRow>
                <TableCell>Board Game</TableCell>
                <TableCell align="center">Min Player</TableCell>
                <TableCell align="center">Max Player</TableCell>
                <TableCell align="center">Description</TableCell>
                <TableCell align="center">Publisher</TableCell>
                <TableCell align="center">Categories</TableCell>
                <TableCell align="center">Rating</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {displayedRows.map((row) => (
                <TableRow key={row.name}>
                  
                  <TableCell component="th" scope="row" style={{ width: 160 }}>
                    <Link border={"none"} href={`/games/${row.publicID}`}>{row.name}</Link>
                  </TableCell>

                  <TableCell
                    component="th"
                    align="center"
                    scope="row"
                    style={{ width: 50 }}
                  >
                    {row.minplayer}
                  </TableCell>

                  <TableCell
                    component="th"
                    align="center"
                    scope="row"
                    style={{ width: 50 }}
                  >
                    {row.maxplayer}
                  </TableCell>
                  <TableCell
                    component="th"
                    align="center"
                    scope="row"
                    style={{ width: 150 }}
                  >
                    {row.description}
                  </TableCell>
                  <TableCell
                    component="th"
                    align="center"
                    scope="row"
                    style={{ width: 50 }}
                  >
                    {row.publisherPublisherName}
                  </TableCell>

                  <TableCell
                    component="th"
                    align="center"
                    scope="row"
                    style={{ width: 50 }}
                  >
                    {row.categories.map((category) => {
                      return <p key={category.publicID}>{category.name}</p>;
                    })}
                  </TableCell>

                  <TableCell style={{ width: 160 }} align="center">
                    {row.rating}
                  </TableCell>
                </TableRow>
              ))}
              {emptyRows > 0 && (
                <TableRow style={{ height: 53 * emptyRows }}>
                  <TableCell colSpan={4} />
                </TableRow>
              )}
            </TableBody>
            <TableFooter>
              <TableRow>
                <TablePagination
                  rowsPerPageOptions={[5, 10, 25, { label: "All", value: -1 }]}
                  colSpan={4}
                  count={rows.length}
                  rowsPerPage={rowsPerPage}
                  page={page}
                  onPageChange={handleChangePage}
                  onRowsPerPageChange={handleChangeRowsPerPage}
                  ActionsComponent={TablePaginationActions}
                />
              </TableRow>
            </TableFooter>
          </Table>
        </TableContainer>
      </div>
      </>
  );
}
