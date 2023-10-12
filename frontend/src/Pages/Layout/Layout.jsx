import { Outlet, Link } from 'react-router-dom';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import Typography from '@mui/material/Typography';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { Button } from '@mui/material';
import { useNavigate } from 'react-router-dom';

import './Layout.css';
import { useEffect } from 'react';


const Layout = () => {

    const username = localStorage.getItem('username');

    const navigate = useNavigate();

    useEffect(() => {

    }, [username])

    return (
        <div className="Layout">
            <nav>
                <ul>
                    <li className="grow">
                        <Link to="/games">All games</Link>
                    </li>
                        <div className="center">
                            {username ? 
                                <Accordion sx={{ width: '250px' }}>
                                    {/* Adjust the width as needed */}
                                    <AccordionSummary
                                        expandIcon={<ExpandMoreIcon />}
                                        aria-controls="panel1a-content"
                                        id="panel1a-header"
                                    >
                                        <Typography>Welcome {username}</Typography>
                                    </AccordionSummary>
                                    <AccordionDetails>
                                        <Button onClick={() => {
                                            navigate("/");
                                        }}>Favourite games</Button>
                                    </AccordionDetails>
                                    <AccordionDetails>
                                        <Button onClick={() => {
                                            localStorage.clear();
                                            navigate("/");
                                        }}>Logout</Button>
                                    </AccordionDetails>
                                </Accordion> : null
                            }
                        </div>
                    <li className='create'>
                        <Link to="/games/create">Create a new game</Link>
                    </li>
                </ul>
            </nav>
            <Outlet />
        </div>
    );
}

export default Layout;
