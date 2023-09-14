import React from 'react'
import ReactDOM from 'react-dom/client'
import Layout from './Pages/Layout/Layout.jsx';
import HomePage from './Pages/HomePage/HomePage.jsx'
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import './index.css'
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';
import GameList from './Pages/GameList.jsx';
import BoardGameCreator from './Pages/BoardGameCreator.jsx';
import ErrorPage from './Pages/ErrorPage.jsx';

const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    errorElement: <ErrorPage />,
    children: [
      {
        path: "/",
        element: <HomePage />,
      },
      {
        path: "/games",
        element: <GameList />,
      },
      {
        path: "/games/create",
        element: <BoardGameCreator />,
      }
    ],
  },
]);

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
)
