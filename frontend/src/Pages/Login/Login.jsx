import "./login.css";

const Login = () => {

    return (
        <section>
            <div className="form-box">
                <div className="form-value">
                    <form action="">
                        <h2>Login</h2>
                        <div className="input-box">
                            <ion-icon name="mail-outline"></ion-icon>
                            <input type="email" name="email" id="email" />
                            <label htmlFor="">E-mail</label>
                        </div>
                        <div className="input-box">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                            <input type="password" name="password" id="password" />
                            <label htmlFor="">Password</label>
                        </div>
                        <div className="forget">
                            <label htmlFor=""><input type="checkbox" name="checkbox" id="checkbox" />Remember me <a href="/forgetpassword">Forget Password</a></label>
                        </div>
                        <button id="login">Log in</button>
                        <div className="register">
                            <p>Dont have an account <a href="games/register">Register</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    );
};

export default Login;