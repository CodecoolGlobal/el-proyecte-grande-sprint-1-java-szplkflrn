import { useState, useEffect } from "react";
import PropTypes from "prop-types";
import FirstPageIcon from "@mui/icons-material/FirstPage";
import KeyboardArrowLeft from "@mui/icons-material/KeyboardArrowLeft";
import KeyboardArrowRight from "@mui/icons-material/KeyboardArrowRight";
import LastPageIcon from "@mui/icons-material/LastPage";

import {
  Link, Rating, FormControl, Select,
  MenuItem, Button, InputLabel, TextField,
  useTheme, TableBody, Table, Box,
  TableCell, TableContainer, TableHead, TableFooter,
  TablePagination, TableRow, Paper, IconButton,
} from "@mui/material";

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
        aria-label="last page"
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
  const [search, setSearch] = useState(false);
  const [description, setDescription] = useState("");
  const [publishers, setPublishers] = useState([]);
  const [categories, setCategories] = useState([]);
  const [chosenCategory, setChosenCategory] = useState("");
  const [chosenPublisher, setChosenPublisher] = useState("");
  const [searchField, setSearchField] = useState("");
  const [maxPlayer, setMaxPlayer] = useState(100);
  const [minPlayer, setMinPlayer] = useState(0);
  const [rating, setRating] = useState(0.0);

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

  const filterGamesFetch = async (searchField) => {
    try {
      const userToken = localStorage.getItem("usertoken");
      const headers = userToken
        ? {
          Authorization: `Bearer ${userToken}`,
          "Content-Type": "application/json",
        }
        : { "Content-Type": "application/json" };
      const response = await fetch(
        `/api/games/search?boardGameName=${searchField}`,
        {
          method: "GET",
          headers: headers,
        }
      );

      if (response.ok) {
        const data = await response.json();
        setGames(data);
      } else {
        console.error(`Error fetching filtered games: ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching filtered games: ", error);
    }
  };

  const categoriesFetch = async () => {
    try {
      const response = await fetch("/api/categories");
      if (!response.ok) {
        throw new Error(`Error fetching categories: ${response.statusText}`);
      }
      const data = await response.json();
      setCategories(data);
    } catch (error) {
      console.error("Error fetching categories:", error);
    }
  };

  const filterByCategoryFetch = async (chosenCategory) => {
    try {
      const response = await fetch(
        `/api/games/category?publicID=${chosenCategory}`
      );
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by categories: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by categories:", error);
    }
  };

  const filterByMaxPlayerFetch = async (maxPlayer) => {
    try {
      const response = await fetch(`/api/games/maxplayer?max=${maxPlayer}`);
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by max player: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by max player:", error);
    }
  };

  const filterByMinPlayerFetch = async (minPlayer) => {
    try {
      const response = await fetch(`/api/games/minplayer?min=${minPlayer}`);
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by min player: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by min player:", error);
    }
  };

  const filterByRatingFetch = async (rating) => {
    try {
      const response = await fetch(`/api/games/rating?rating=${rating}`);
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by ratings: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by ratings:", error);
    }
  };

  const filterByDescriptionFetch = async (description) => {
    try {
      const response = await fetch(
        `/api/games/description?desc=${description}`
      );
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by description: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by description:", error);
    }
  };

  const filterByPublisherFetch = async (chosenPublisher) => {
    try {
      const response = await fetch(
        `/api/games/publisher?publicID=${chosenPublisher}`
      );
      if (!response.ok) {
        throw new Error(`Error fetching games filtered by publisher: ${response.statusText}`);
      }
      const data = await response.json();
      setGames(data);
    } catch (error) {
      console.error("Error fetching games filtered by publisher:", error);
    }
  };

  const publishersFetch = async () => {
    try {
      const response = await fetch("/api/publishers");
      if (!response.ok) {
        throw new Error(`Error fetching publishers: ${response.statusText}`);
      }
      const data = await response.json();
      setPublishers(data);
    } catch (error) {
      console.error("Error fetching publishers:", error);
    }
  };

  useEffect(() => {
    gamesFetch();
    publishersFetch();
    categoriesFetch();
  }, []);

  useEffect(() => {
    if (searchField.length > 0) {
      filterGamesFetch(searchField);
    } else {
      setSearchField("");
      filterGamesFetch(searchField);
    }
  }, [searchField]);

  useEffect(() => {
    if (chosenPublisher.length > 0) {
      filterByPublisherFetch(chosenPublisher);
    }
  }, [chosenPublisher]);

  useEffect(() => {
    if (chosenCategory.length > 0) {
      filterByCategoryFetch(chosenCategory);
    }
  }, [chosenCategory]);

  useEffect(() => {
    if (description.length > 0) {
      filterByDescriptionFetch(description);
    } else {
      setSearchField("");
      filterByDescriptionFetch(description);
    }
  }, [description]);

  useEffect(() => {
    if (minPlayer > 0) {
      filterByMinPlayerFetch(minPlayer);
    } else {
      setMinPlayer(0);
      filterByMinPlayerFetch(minPlayer);
    }
  }, [minPlayer]);

  useEffect(() => {
    if (maxPlayer < 100) {
      filterByMaxPlayerFetch(maxPlayer);
    } else {
      setMaxPlayer(100);
      filterByMaxPlayerFetch(maxPlayer);
    }
  }, [maxPlayer]);

  useEffect(() => {
    if (rating > 0) {
      filterByRatingFetch(rating);
    } else {
      setRating(0.0);
      filterByRatingFetch(rating);
    }
  }, [rating]);

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

  const handleChangeOnPublisher = (event) => {
    setChosenPublisher(event.target.value);
  };

  const handleChangeOnCategory = (event) => {
    setChosenCategory(event.target.value);
  };

  const handleChangeOnSearchGame = (event) => {
    if (event.target.value !== null) {
      setSearchField(event.target.value);
    } else {
      setSearchField("");
    }
  };

  const handleChangeOnDescription = (event) => {
    if (event.target.value !== null) {
      setDescription(event.target.value);
    } else {
      setDescription("");
    }
  };

  const handleChangeOnRating = (event) => {
    if (event.target.value !== null) {
      setRating(event.target.value);
    } else {
      setRating(0.0);
    }
  };

  const handleChangeOnMaxPlayer = (event) => {
    if (event.target.value !== null) {
      setMaxPlayer(event.target.value);
    } else {
      setMaxPlayer(100);
    }
  };

  const handleChangeOnMinPlayer = (event) => {
    if (event.target.value !== null) {
      setMinPlayer(event.target.value);
    } else {
      setMinPlayer(0);
    }
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
          sx={{ maxWidth: 1200, margin: "auto", opacity: 0.9 }}
          align="center"
        >
          <Table sx={{ minWidth: 500 }} aria-label="custom pagination table">
            <TableHead>
              {search ? (
                <TableRow>
                  <TableCell>
                    <TextField
                      label="Game"
                      onChange={handleChangeOnSearchGame}
                    />
                  </TableCell>
                  <TableCell>
                    <TextField
                      inputProps={{ type: "number", min: 1 }}
                      label="Min Player"
                      onChange={handleChangeOnMinPlayer}
                    />
                  </TableCell>
                  <TableCell>
                    <TextField
                      inputProps={{ type: "number", min: 1 }}
                      label="Max Player"
                      onChange={handleChangeOnMaxPlayer}
                    />
                  </TableCell>
                  <TableCell>
                    <TextField
                      label="Description"
                      onChange={handleChangeOnDescription}
                    />
                  </TableCell>
                  <TableCell>
                    <FormControl sx={{ width: 200 }}>
                      <InputLabel id="publishers">Publisher</InputLabel>
                      <Select
                        labelId="publishers"
                        id="select-publisher"
                        value={chosenPublisher}
                        label="Publisher"
                        onChange={handleChangeOnPublisher}
                      >
                        {publishers.map((publisher, index) => (
                          <MenuItem
                            key={publisher.publisherName + index}
                            value={publisher.publicID}
                          >
                            {publisher.publisherName}
                          </MenuItem>
                        ))}
                      </Select>
                    </FormControl>
                  </TableCell>
                  <TableCell>
                    <FormControl sx={{ width: 200 }}>
                      <InputLabel id="categories">Category</InputLabel>
                      <Select
                        labelId="categories"
                        id="select-category"
                        value={chosenCategory}
                        label="Category"
                        onChange={handleChangeOnCategory}
                      >
                        {categories && categories.map((category, index) => (
                          <MenuItem key={category.name + index} value={category.publicID}>
                            {category.name}
                          </MenuItem>
                        ))}
                      </Select>
                    </FormControl>
                  </TableCell>
                  <TableCell>
                    <TextField
                      inputProps={{ type: "number", min: 0 }}
                      label="Rating"
                      onChange={handleChangeOnRating}
                    />
                  </TableCell>
                </TableRow>
              ) : (
                <TableRow>
                  <TableCell></TableCell>
                  <TableCell></TableCell>
                  <TableCell></TableCell>
                  <TableCell align="center">
                    <Button onClick={() => setSearch(true)} variant="text">
                      Advanced search
                    </Button>
                  </TableCell>
                  <TableCell></TableCell>
                  <TableCell></TableCell>
                  <TableCell></TableCell>
                </TableRow>
              )}
              <TableRow>
                <TableCell align="center">Board Game</TableCell>
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
                    <Link border={"none"} href={`/games/${row.publicID}`}>
                      {row.name}
                    </Link>
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
                    {row.categories === undefined
                      ? ""
                      : row.categories.map((category) => {
                        return <p key={category.publicID}>{category.name}</p>;
                      })}
                  </TableCell>
                  <TableCell style={{ width: 160 }} align="center">
                    <Rating name="half-rating-read" defaultValue={row.rating} precision={0.1} readOnly />
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
