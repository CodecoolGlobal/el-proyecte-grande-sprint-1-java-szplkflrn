
const BoardGameForm = ({ onSave, disabled, boardGame, onCancel }) => {

  const onSubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    const entries = [...formData.entries()];
  
    const isAnyFieldEmpty = entries.some(([, v]) => !v);
  
    if (isAnyFieldEmpty) {
      alert("Please fill in all the fields");
      return; 
    }
  
    const boardGame = entries.reduce((acc, entry) => {
      const [k, v] = entry;
      acc[k] = v;
      return acc;
    }, {});
  
    onSave(boardGame);
  };

  return (
    <div className="BoardForm">
      <form className="BoardGameForm" onSubmit={onSubmit}>
        {boardGame && <input type="hidden" name="_id" defaultValue={boardGame.id} />}
        <br></br>
        <div className="control">
          <label htmlFor="id">Id: </label>
          <input
            type="number"
            name="id"
            id="id"
          />
        </div>
        <div className="control">
          <label htmlFor="gameName">Name: </label>
          <input
            name="gameName"
            id="gameName"
          />
        </div>
        <div className="control">
          <label htmlFor="minPlayer">Min Player: </label>
          <input
            type="number"
            name="minPlayer"
            id="minPlayer"
          />
        </div>
        <div className="control">
          <label htmlFor="maxPlayer">Max Player: </label>
          <input
            type="number"
            name="maxPlayer"
            id="maxPlayer"
          />
        </div>
        <div className="control">
          <label htmlFor="playTimeInMinutes">Playtime (minutes): </label>
          <input
            type="number"
            name="playTimeInMinutes"
            id="playTimeInMinutes"
          />
        </div>

        <div className="control">
          <label htmlFor="recommendedAge">Rec. age: </label>
          <input
            type="number"
            name="recommendedAge"
            id="recommendedAge"
          />
        </div>
        <div className="control">
          <label htmlFor="description">Description: </label>
          <input
            name="description"
            id="description"
          />
        </div>
        <div className="control">
          <label htmlFor="rating">Rating: </label>
          <input
            type="number"
            step="0.5"
            max='10'
            name="rating"
            id="rating"
          />
        </div>
        <div className="control">
          <label htmlFor="publisherId">Publisher id: </label>
          <input
            type="number"
            name="publisherId"
            id="publisherId"
          />
        </div>
        <div className="control">
          <label htmlFor="categoryId">Category id: </label>
          <input
            type="number"
            name="categoryId"
            id="categoryId"
          />
        </div><br></br>


        <div className="buttons">
          <button type="submit" disabled={disabled}>
            Create BoardGame
          </button>
          <br></br>
          <br></br>
          <button type="button" onClick={onCancel}>
            Cancel
          </button>
        </div>
        <br></br>
      </form>
    </div>
  );
};

export default BoardGameForm;
