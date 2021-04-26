import React from 'react';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import App from "./App";

function printMainTechnologies(technologies){ 
  return (technologies.filter(technology => technology.is_main_tech)
          .map((technology)=>(technology.name))
          .reduce( (prevName, name) => prevName + ", " + name));
}

const Candidate = ({ id, city, district, years_experience, technologies }) => {
    return (<>
    <tr>
      <th scope="row">{id}</th>
      <td>{city}</td>
      <td>{district}</td>
      <td>{years_experience}</td>
      <td>{printMainTechnologies(technologies)}</td>
    </tr>
    </>
    );
};

export default Candidate;