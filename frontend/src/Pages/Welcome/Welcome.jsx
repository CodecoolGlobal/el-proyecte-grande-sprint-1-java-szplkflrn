import Layout from '../Layout/Layout';

const WelcomeMessage = () => {
    const DisplayMessage = () => {
        const username = localStorage.getItem("username");
        if (username) {
            return <h3>Welcome {username}</h3>;
        } 
    };

    return (
        <Layout onDisplay={DisplayMessage} />
    );
};

export default WelcomeMessage;

