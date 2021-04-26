import React, { useState, useEffect } from 'react';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import App from "./App";
import { Typeahead } from 'react-bootstrap-typeahead';


const FormCandidates = (props) => {
    const [ city, setCity ] = useState('')
    const [ yearsMin, setYearsMin ] = useState('')
    const [ yearsMax, setYearsMax ] = useState('')
    const [ technology, setTechnology ] = useState('')
    // let city = '';
    // let yearsMin = '';
    // let yearsMax = '';
    // let technology = '';
    
    const [ cityOptions, setCityOptions ] = useState([]);
    const [ technologyOptions, setTechnologyOptions ] = useState([]);
    const yearsOptions = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'];
    

    const baseUrl = 'https://candidatosgh.herokuapp.com';

    function getCandidatesFromApiJSON() {
      const url = baseUrl+"/candidates/list_best_matches?years_experience_min="+yearsMin+
      "&years_experience_max="+yearsMax+"&city="+city+"&technologies="+encodeURIComponent(technology);

      console.log(technology);
      console.log(url);

      return fetch(url)
        .then(res => res.json());        
        //.then(candidates_top_5 => props.setCandidates(candidates_top_5)); 
    }

    // Run on load
    useEffect(() => {
      getCandidatesCities();
      getCandidateTechnologies();
    }, []);   

    async function getCandidatesCities() {
      const url = baseUrl+"/candidates/cities";
      fetch(url)
        .then(res => res.json())
        .then(result => {
          setCityOptions(result);
        });      
    }

    async function getCandidateTechnologies() {
      const url = baseUrl+"/candidate_technologies";
      fetch(url)
        .then(res => res.json())
        .then(result => {
          setTechnologyOptions(result);
        });      
    }

    return (<>
      <Form>
        <Form.Group controlId="formCity">
          <Form.Label>Cidade</Form.Label>
          <input type="text" className="form-control" onChange={(e)=>{setCity(e.currentTarget.value)}} 
                defaultValue = {""} list="cityList" />
          <datalist id="cityList">
            {cityOptions.map((city) =>
              <option value={city} />
            )}
          </datalist>
        </Form.Group>

        <Form.Group controlId="formYearsMin">
          <Form.Label>Anos de experiência mínimo</Form.Label>
          <input type="text" className="form-control"  onChange={(e)=>{setYearsMin(e.currentTarget.value)}} 
                defaultValue = {""} list="yearsList" />
          <datalist id="yearsList">
            {yearsOptions.map((years) =>
              <option value={years} />
            )}
          </datalist>
        </Form.Group>

        <Form.Group controlId="formYearsMax">
          <Form.Label>Anos de experiência máximo</Form.Label>
          <input type="text" className="form-control" onChange={(e)=>{setYearsMax(e.currentTarget.value)}} 
                defaultValue = {""} list="yearsList" />
          <datalist id="yearsList">
            {yearsOptions.map((years) =>
              <option value={years} />
            )}
          </datalist>
        </Form.Group>

        <Form.Group controlId="formTechnology">
          <Form.Label>Tecnologia</Form.Label>
          <input type="text" className="form-control" onChange={(e)=>{setTechnology(e.target.value)}} 
                defaultValue = {""} list="techList" />
          <datalist id="techList">
            {technologyOptions.map((technologies) =>
              <option value={technologies} />
            )}
          </datalist>
        </Form.Group>

        <Button onClick={() => getCandidatesFromApiJSON().then(candidates_top_5 => props.setCandidates(candidates_top_5))}>
          Listar candidatos
        </Button>
      </Form>
      </>
    );
};

export default FormCandidates;

