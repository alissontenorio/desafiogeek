import React, { useState } from 'react';
import Button from 'react-bootstrap/Button';
import FormCandidates from "./FormCandidates";
import Candidate from "./Candidate";

function printCandidates(candidates) {
  return (
    candidates.map(
      (candidate) => (
        <React.Fragment key={candidate.id}>
          <Candidate
            id={candidate.id}
            city={candidate.city}
            district={candidate.district}
            years_experience={candidate.years_experience}
            technologies={candidate.candidate_technologies}
          /> 
        </React.Fragment>
      )
    ) 
  )
}

function App() {
  const [candidates, setCandidates] = useState([]);

  return (
    <div className="App">
      <FormCandidates setCandidates={setCandidates}></FormCandidates>
      
        <h2><br></br>
        <p>Lista 5 melhores candidatos</p>
        </h2>
      <table className="table">
        <thead>
          <tr>
            <th scope="col">Id</th>
            <th scope="col">Cidade</th>
            <th scope="col">Estado</th>
            <th scope="col">Anos de experiência</th>
            <th scope="col">Principais tecnologias</th>
          </tr>
        </thead>
        <tbody>
          {printCandidates(candidates)}   
        </tbody>
      </table>
      
    </div>
  );
}

export default App;
