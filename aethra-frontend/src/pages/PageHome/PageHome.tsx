// src/pages/PageHome.tsx
import React from 'react';
import { Container } from 'react-bootstrap';
import CitiesWeather from '../../components/CitiesWeather'; // Adjust the path if necessary
import MapComponent from '../../components/MapComponent'; // Import the new MapComponent
import './PageHome.css';

const PageHome: React.FC = () => {
    return (
        <Container>
            <MapComponent />
            <CitiesWeather />
            {/* AdSense units will be handled by the HTML */}
        </Container>
    );
};

export default PageHome;
