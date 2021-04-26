import logo from './logo.svg';
import './App.css';

async function getCandidatesFromApi() {


  fetch('https://candidatosgh.herokuapp.com/candidates/list_best_matches/1/Blumenau/Java'
    ,{
      credentials: "include"
    }
    )
      .then(function(response){
        console.log(response)
        return response.json();
      })
}


function App() {
  return (
    <div className="App">
      <header className="App-header">
        <p>
          Lista 5 melhores candidatos
        </p>
        <button onClick={() => getCandidatesFromApi()}>Listar candidatos</button>
        
      </header>
    </div>
  );
}

export default App;
