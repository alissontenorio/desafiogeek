import logo from './logo.svg';
import './App.css';

async function getCandidatesFromApi() {
  try {
    let response = await fetch('http://127.0.0.1:3000/candidates/list_best_matches/1/Blumenau/Java');
    let responseJson = await response.json();

    console.log(JSON.stringify(responseJson))

    return responseJson;
   } catch(error) {
    console.error(error);
  }
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
