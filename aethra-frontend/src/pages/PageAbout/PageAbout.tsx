// src/pages/PageAbout.tsx
import React from 'react';
import { useTranslation } from 'react-i18next';
import { Helmet } from 'react-helmet';
import './PageAbout.css';

const PageAbout: React.FC = () => {
    const { t } = useTranslation();

    return (
        <div className="container my-5">
            <Helmet>
                <title>{t('aboutUs')}</title>
            </Helmet>
            <div className="row">
                <div className="col-12 text-center">
                    <h1 className="mb-4">{t('aboutUs')}</h1>
                    <p className="lead">{t('information')}</p>
                </div>
            </div>
        </div>
    );
};

export default PageAbout;
