import React, { useState } from 'react';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import App from "./App";
import { Typeahead } from 'react-bootstrap-typeahead';


const FormCandidates = (props) => {
    const [ city, setCity ] = useState('')
    const [ years, setYears ] = useState('')
    const [ technology, setTechnology ] = useState('')

    const cityOptions = [ 'Porto Alegre', "Maceió" ]
    const yearsOptions = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16']
    const technologyOptions = ['Java', 'React']

    async function getCandidatesFromApiJSON() {
      // const response = await fetch(
      //   "https://candidatosgh.herokuapp.com/candidates/list_best_matches/1/Blumenau/Java");
      //let url2 = "https://candidatosgh.herokuapp.com/candidates/list_best_matches/1/Blumenau/Java";
      let url = "https://candidatosgh.herokuapp.com/candidates/list_best_matches/"+years+"/"+city+"/"+technology;
  
      const response = await fetch(url);
      const candidates_top_5 = await response.json();  
      return candidates_top_5;
    }

    return (<>
      <Form>
        <Form.Group controlId="formCity">
          <Form.Label>Cidade</Form.Label>
          {/* <Form.Control type="text" onChange={ e => setCity(e.target.value)}
              placeholder="Digite critério de cidade" /> */}
          <Typeahead
            labelKey="city"
            onChange={setCity}
            options={cityOptions}
            placeholder="Digite critério de cidade..."
            selected={city}
          />
        </Form.Group>

        <Form.Group controlId="formYears">
          <Form.Label>Anos de experiência</Form.Label>
          {/* <Form.Control type="text" 
              onChange={ e => setYears(e.target.value)} placeholder="Digite critério de anos de experiência" /> */}
          <Typeahead
            labelKey="years"
            onChange={setYears}
            options={yearsOptions}
            placeholder="Digite ano de experiência mínimo..."
            selected={years}
          />
        </Form.Group>

        <Form.Group controlId="formTechnology">
          <Form.Label>Tecnologia</Form.Label>
          {/* <Form.Control type="text" 
              onChange={ e => setTechnology(e.target.value)} placeholder="Digite critério de tecnologia" /> */}
          <Typeahead
            labelKey="technology"
            onChange={setTechnology}
            options={technologyOptions}
            placeholder="Digite critério de tecnologia..."
            selected={technology}
          />
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

        <Button onClick={() => getCandidatesFromApiJSON().then(candidates => props.setCandidates(candidates))}>
          Listar candidatos
        </Button>
      </Form>
      </>
    );
};

export default FormCandidates;

