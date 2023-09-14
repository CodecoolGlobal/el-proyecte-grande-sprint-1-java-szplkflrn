import {Outlet, Link} from "react-router-dom";

import "./Layout.css";

const Layout = () => (
    <div className="Layout">
        <nav>
            <ul>
                <li className="grow">
                    <Link to="/games">All games</Link>
                </li>
                <li>
                    <Link to="/games/create">Create a new game</Link>
                </li>
            </ul>
        </nav>
        <Outlet/>
    </div>
);

export default Layout;
