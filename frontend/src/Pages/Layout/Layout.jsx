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
                <Button className="grow">
                        <Link to="/">Home</Link>
                    </Button>
                    <li className="grow">
                        <Link to="/games">All games</Link>
                    </li>
                        <div className="center">
                            {username ? 
                                <Accordion sx={{ width: '220px' }}>
                                    <AccordionSummary
                                        expandIcon={<ExpandMoreIcon />}
                                        aria-controls="panel1a-content"
                                        id="panel1a-header"
                                    >
                                        <Typography>Welcome: <b>{username}</b></Typography>
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
                                            location.reload()
                                        }}>Logout</Button>
                                    </AccordionDetails>
                                </Accordion> : null
                            }
                        </div>
                        {localStorage.userrole === "ADMIN" ?  <li className='create'>
                        <Link to="/games/create">Create a new game</Link>
                    </li> : null}
                   
                </ul>
            </nav>
            <Outlet />
        </div>
    );
}

export default Layout;
