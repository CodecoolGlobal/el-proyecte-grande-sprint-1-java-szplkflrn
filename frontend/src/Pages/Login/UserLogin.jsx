import Login from "./Login";
import { useNavigate } from "react-router-dom";

const UserLogin = () => {
    const navigate = useNavigate();

        return (
            <Login
                onCancel={() => navigate("/")}
            />
        );

}

export default UserLogin;