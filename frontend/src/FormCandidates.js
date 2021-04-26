import React, { useState, useEffect } from 'react';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import App from "./App";
import { Typeahead } from 'react-bootstrap-typeahead';


const FormCandidates = (props) => {
    const [ city, setCity ] = useState('')
    const [ years, setYears ] = useState('')
    const [ technology, setTechnology ] = useState('')
    
    const [ cityOptions, setCityOptions ] = useState([])
    const [ technologyOptions, setTechnologyOptions ] = useState([])
    const yearsOptions = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']
    

    const baseUrl = 'https://candidatosgh.herokuapp.com'

    async function getCandidatesFromApiJSON() {
      /*let url = "https://candidatosgh.herokuapp.com/candidates/list_best_matches/"+years+"/"+city+"/"+technology;
  
      const response = await fetch(url);
      const candidates_top_5 = await response.json(); */
      
      const url = baseUrl+"/candidates/list_best_matches?years_experience="+years+"&city="+city+"&technologies="+technology;
      console.log(url);
      return fetch(url)
        .then(res => res.json());        
        //.then(candidates_top_5 => props.setCandidates(candidates_top_5)); 
    }

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
          {/* <Typeahead
            allowNew
            labelKey="city"
            onChange={setCity}
            options={cityOptions}
            placeholder="Digite critério de cidade..."
            selected={city}
          /> */}
          <input type="text" class="form-control" onChange={(e)=>{setCity(e.currentTarget.value)}} 
                defaultValue = {""} list="cityList" />
          <datalist id="cityList">
            {cityOptions.map((city) =>
              <option value={city} />
            )}
          </datalist>
        </Form.Group>

        <Form.Group controlId="formYears">
          <Form.Label>Anos de experiência</Form.Label>
          {/* <Typeahead
            labelKey="years"
            onChange={setYears}
            options={yearsOptions}
            placeholder="Digite ano de experiência mínimo..."
            selected={years}
          /> */}
          <input type="text" class="form-control" onChange={(e)=>{setYears(e.currentTarget.value)}} 
                defaultValue = {""} list="yearsList" />
          <datalist id="yearsList">
            {yearsOptions.map((years) =>
              <option value={years} />
            )}
          </datalist>
        </Form.Group>

        <Form.Group controlId="formTechnology">
          <Form.Label>Tecnologia</Form.Label>
          {/* <Form.Control type="text" 
              onChange={ e => setTechnology(e.target.value)} placeholder="Digite critério de tecnologia" /> */}
          <input type="text" class="form-control" onChange={(e)=>{setTechnology(e.currentTarget.value)}} 
                defaultValue = {""} list="techList" />
          <datalist id="techList">
            {technologyOptions.map((technologies) =>
              <option value={technologies} />
            )}
          </datalist>
          {/* <Typeahead
            labelKey="technology"
            onChange={setTechnology}
            options={technologyOptions}
            placeholder="Digite critério de tecnologia..."
            selected={technology}
          /> */}
          {/* <Typeahead
            id="basic-typeahead-multiple"
            labelKey="name"
            multiple
            onChange={setMultiSelections}
            options={options}
            placeholder="Choose several states..."
            selected={multiSelections}
          /> */}
        </Form.Group>

        <Button onClick={() => getCandidatesFromApiJSON().then(candidates_top_5 => props.setCandidates(candidates_top_5))}>
          Listar candidatos
        </Button>
      </Form>
      </>
    );
};

export default FormCandidates;

