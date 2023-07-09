var treeData = [{
    "name": "Epilepsy Classification",
    "parent": "null",
    "_children": [

        // ****** Seizure Type ******

        {
            "name": "Seizure Type",
            "parent": "Epilepsy Classification",
            "_children": [

                // *** Generalised ***
                {
                    "name": "Generalised",
                    "parent": "Seizure Type",
                    "_children": [{
                            "name": "Motor",
                            "parent": "Generalised",
                            "_children": [{
                                    "name": "Generalized tonic-clonic and variants",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Generalized tonic",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Generalized atonic",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Myoclonic",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Myoclonic-atonic",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Epileptic spasms",
                                    "parent": "Motor"
                                }
                            ]
                        },
                        {
                            "name": "Non-motor",
                            "parent": "Generalised",
                            "_children": [{
                                "name": "Typical Absence",
                                "parent": "Non-motor"
                            }, {
                                "name": "Atypical Absence",
                                "parent": "Non-motor"
                            }, {
                                "name": "Myoclonic absence",
                                "parent": "Non-motor"
                            }, {
                                "name": "Absence with eyelid myoclonia",
                                "parent": "Non-motor"
                            }]
                        }
                    ]
                },

                // *** Focal ***
                {
                    "name": "Focal",
                    "parent": "Seizure Type",
                    "_children": [{
                            "name": "Awareness",
                            "parent": "Focal",
                            "_children": [{
                                "name": "Aware",
                                "parent": "Awareness",
                            }, {
                                "name": "Impaired Awareness",
                                "parent": "Awareness",
                            }]
                        },
                        {
                            "name": "Motor",
                            "parent": "Focal",
                            "_children": [{
                                    "name": "Focal clonic seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal tonic seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal motor seizure with dystonia",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal myoclonic seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal atonic seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal motor seizure with paresis/paralysis",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal epileptic spasms",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal hyperkinetic seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal automatism seizure",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal motor seizure with dysarthria / anarthria",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal motor seizure with negative myoclonus",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal motor seizure with version",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Focal bilateral motor seizure",
                                    "parent": "Motor"
                                }
                            ]
                        },
                        {
                            "name": "Non-motor",
                            "parent": "Focal",
                            "_children": [{
                                    "name": "Focal sensory seizure",
                                    "parent": "Non-motor",
                                    "_children": [{
                                        "name": "Focal somatosensory seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory visual seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory auditory seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory olfactory seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory gustatory seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory vestibular seizure",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory seizure with hot-cold sensations",
                                        "parent": "Focal sensory seizure"
                                    }, {
                                        "name": "Focal sensory seizure with cephalic sensation",
                                        "parent": "Focal sensory seizure"
                                    }]
                                },
                                {
                                    "name": "Focal cognitive seizure",
                                    "parent": "Non-motor",
                                    "_children": [{
                                        "name": "Focal cognitive seizure with expressive dysphasia / aphasia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with anomia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with receptive dysphasia / aphasia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with auditory agnosia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with conduction dysphasia / aphasia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with dyslexia / alexia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with memory impairment",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with deja vu / jamais vu",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with hallucination",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with illusion",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with dissociation",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with forced thinking",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with dyscalculia / acalculia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with dysgraphia/agraphia",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with left-right confusion",
                                        "parent": "Focal cognitive seizure"
                                    }, {
                                        "name": "Focal cognitive seizure with neglect",
                                        "parent": "Focal cognitive seizure"
                                    }]
                                },
                                {
                                    "name": "Focal emotional seizure",
                                    "parent": "Non-motor",
                                    "_children": [{
                                        "name": "Focal emotional seizure with fear/anxiety/panic",
                                        "parent": "Focal emotional seizure"
                                    }, {
                                        "name": "Focal emotional seizure with laughing (gelastic)",
                                        "parent": "Focal emotional seizure"
                                    }, {
                                        "name": "Focal emotional seizure with crying (dacrystic)",
                                        "parent": "Focal emotional seizure"
                                    }, {
                                        "name": "Focal emotional seizure with pleasure",
                                        "parent": "Focal emotional seizure"
                                    }, {
                                        "name": "Focal emotional seizure with anger",
                                        "parent": "Focal emotional seizure"
                                    }]
                                },
                                {
                                    "name": "Focal autonomic seizure",
                                    "parent": "Non-motor",
                                    "_children": [{
                                        "name": "Focal autonomic seizure with palpitations / tachycardia / bradycardia / asystole",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with epigastric sensation",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with pallor / flushing",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with hypoventilation / hyperventilation / altered respiration",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with piloerection",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with erection",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with urge to urinate / defecate",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with lacrimation",
                                        "parent": "Focal autonomic seizure"
                                    }, {
                                        "name": "Focal autonomic seizure with pupillary dilation / constriction",
                                        "parent": "Focal autonomic seizure"
                                    }]
                                },
                                {
                                    "name": "Focal behavioural arrest seizure",
                                    "parent": "Non-motor",
                                    "_children": [{
                                        "name": "Focal behavioural arrest seizure",
                                        "parent": "Focal behavioural arrest seizure"
                                    }]
                                }
                            ]
                        },
                        {
                            "name": "Focal to bilateral tonic-clonic seizure",
                            "parent": "Focal",
                            "_children": [{
                                "name": "Focal to bilateral tonic-clonic seizure",
                                "parent": "Focal to bilateral tonic-clonic seizure"
                            }]
                        }
                    ]
                },

                // *** Unknown ***
                {
                    "name": "Unknown",
                    "parent": "Seizure Type",
                    "_children": [{
                            "name": "Motor",
                            "parent": "Focal",
                            "_children": [{
                                    "name": "Tonic–clonic",
                                    "parent": "Motor"
                                },
                                {
                                    "name": "Epileptic spasms",
                                    "parent": "Motor"
                                }
                            ]
                        },
                        {
                            "name": "Non-motor",
                            "parent": "Focal",
                            "_children": [{
                                "name": "Behaviour arrest",
                                "parent": "Non-motor"
                            }, {
                                "name": "Unclassified",
                                "parent": "Non-motor"
                            }]
                        }
                    ]
                }
            ]
        },

        // ****** Epilepsy Type ******

        {
            "name": "Epilepsy Type",
            "parent": "Epilepsy Classification",
            "_children": [{
                "name": "Generalised Epilepsy",
                "parent": "Epilepsy Type"
            }, {
                "name": "Focal Epilepsy",
                "parent": "Epilepsy Type"
            }, {
                "name": "Combined generalised and focal Epilepsy",
                "parent": "Epilepsy Type"
            }, {
                "name": "Unknown Epilepsy",
                "parent": "Epilepsy Type"
            }]
        },

        // ****** Epilepsy Syndrome ******

        {
            "name": "Epilepsy Syndrome",
            "parent": "Epilepsy Classification",
            "_children": [{
                "name": "Neonatal/Infantile",
                "parent": "Epilepsy Syndrome",
                "_children": [{
                    "name": "Self-limited neonatal seizures and Self-limited familial neonatal epilepsy",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Self limited familial and non-familial infantile epilepsy",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Early myoclonic encephalopathy",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Ohtahara syndrome",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "West syndrome",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Dravet syndrome",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Myoclonic epilepsy in infancy",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Epilepsy of infancy with migrating focal seizures",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Myoclonic encephalopathy in non-progressive disorders",
                    "parent": "Neonatal/Infantile"
                }, {
                    "name": "Febrile seizures plus, genetic epilepsy with febrile seizures plus",
                    "parent": "Neonatal/Infantile"
                }]
            }, {
                "name": "Childhood",
                "parent": "Epilepsy Syndrome",
                "_children": [{
                    "name": "Epilepsy with myoclonic-atonic seizures",
                    "parent": "Childhood"
                }, {
                    "name": "Epilepsy with eyelid myoclonias",
                    "parent": "Childhood"
                }, {
                    "name": "Lennox-Gastaut syndrome",
                    "parent": "Childhood"
                }, {
                    "name": "Childhood absence epilepsy",
                    "parent": "Childhood"
                }, {
                    "name": "Epilepsy with myoclonic absences",
                    "parent": "Childhood"
                }, {
                    "name": "Panayiotopoulos syndrome",
                    "parent": "Childhood"
                }, {
                    "name": "Childhood occipital epilepsy (Gastaut type)",
                    "parent": "Childhood"
                }, {
                    "name": "Photosensitive occipital lobe epilepsy",
                    "parent": "Childhood"
                }, {
                    "name": "Childhood epilepsy with centrotemporal spikes",
                    "parent": "Childhood"
                }, {
                    "name": "Atypical childhood epilepsy with centrotemporal spikes",
                    "parent": "Childhood"
                }, {
                    "name": "Epileptic encephalopathy with continuous spike-and-wave during sleep",
                    "parent": "Childhood"
                }, {
                    "name": "Landau-Kleffner syndrome",
                    "parent": "Childhood"
                }, {
                    "name": "Autosomal dominant nocturnal frontal lobe epilepsy",
                    "parent": "Childhood"
                }]
            }, {
                "name": "Adolescent/Adult",
                "parent": "Epilepsy Syndrome",
                "_children": [{
                    "name": "Juvenile absence epilepsy",
                    "parent": "Adolescent/Adult"
                }, {
                    "name": "Juvenile myoclonic epilepsy",
                    "parent": "Adolescent/Adult"
                }, {
                    "name": "Epilepsy with generalized tonic-clonic seizures alone",
                    "parent": "Adolescent/Adult"
                }, {
                    "name": "Autosomal dominant epilepsy with auditory features",
                    "parent": "Adolescent/Adult"
                }, {
                    "name": "Other familial temporal lobe epilepsies",
                    "parent": "Adolescent/Adult"
                }]
            }, {
                "name": "Any Age",
                "parent": "Epilepsy Syndrome",
                "_children": [{
                        "name": "Familial focal epilepsy with variable foci",
                        "parent": "Any Age"
                    },
                    {
                        "name": "Reflex epilepsies",
                        "parent": "Any Age"
                    }, {
                        "name": "Progressive myoclonus epilepsies",
                        "parent": "Any Age"
                    }
                ]
            }]
        },

        // ****** Etiology ******

        {
            "name": "Etiology",
            "parent": "Epilepsy Classification",
            "_children": [{
                "name": "Genetic Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Chromosomal abnormalities",
                    "parent": "Genetic Etiology"
                }, {
                    "name": "Gene abnormalities",
                    "parent": "Genetic Etiology"
                }]
            }, {
                "name": "Structural Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Malformations of cortical development",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Vascular malformations",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Hippocampal sclerosis",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Hypoxic-ischemic structural abnormalities",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Traumatic Brain Injury",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Tumors",
                    "parent": "Structural Etiology"
                }, {
                    "name": "Porencephalic cyst",
                    "parent": "Structural Etiology"
                }]
            }, {
                "name": "Metabolic Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Biotinidase and holocarboxylase synthase deficiency",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Cerebral folate deficiency",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Creatine disorders",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Folinic acid responsive seizures",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Glucose transporter 1 (GLUT1) deficiency",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Mitochondrial disorders",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Peroxisomal Disorders",
                    "parent": "Metabolic Etiology"
                }, {
                    "name": "Pyridoxine dependent epilepsy/PNPO deficiency",
                    "parent": "Metabolic Etiology"
                }]
            }, {
                "name": "Immune Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Rasmussen syndrome",
                    "parent": "Immune Etiology"
                }, {
                    "name": "Antibody mediated etiologies",
                    "parent": "Immune Etiology"
                }]
            }, {
                "name": "Infectious Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Bacterial Meningitis",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Cerebral Malaria",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Cerebral Toxoplasmosis",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "CMV",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "HIV",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Neurocysticercosis",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Tuberculosis",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Viral Encephalitis",
                    "parent": "Infectious Etiology"
                }, {
                    "name": "Other infections",
                    "parent": "Infectious Etiology"
                }]
            }, {
                "name": "Unknown Etiology",
                "parent": "Etiology",
                "_children": [{
                    "name": "Febrile infection related epilepsy syndrome (FIRES)",
                    "parent": "Unknown Etiology"
                }]
            }]
        }
    ]
}];
