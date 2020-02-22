{
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceType",
                  "value": "Microsoft.Resources/resources",
                  "isOptional": true
                },
                {
                  "name": "filter",
                  "isOptional": true
                },
                {
                  "name": "scope",
                  "isOptional": true
                },
                {
                  "name": "kind",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/BrowseAllResourcesPinnedPart"
            }
          },
          "1": {
            "position": {
              "x": 6,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "ComponentId",
                  "value": "${app_insights_id}"
                }
              ],
              "type": "Extension/AppInsightsExtension/PartType/AppMapGalPt",
              "settings": {},
              "asset": {
                "idInputName": "ComponentId",
                "type": "ApplicationInsights"
              }
            }
          },
          "2": {
            "position": {
              "x": 12,
              "y": 0,
              "colSpan": 2,
              "rowSpan": 3
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/Microsoft_Azure_Security/PartType/SecurityMetricGalleryTileViewModel"
            }
          },
          "3": {
            "position": {
              "x": 0,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                              "id": "${app_service_id}"
                          },
                          "name": "AverageResponseTime",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average Response Time",
                            "resourceDisplayName": "${app_service_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                              "id": "${app_service_id}"
                          },
                          "name": "Requests",
                          "aggregationType": 7,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Requests",
                            "resourceDisplayName": "${app_service_name}"
                          }
                        }
                      ],
                      "title": "Avg Average Response Time and Count Requests for ${app_service_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "4": {
            "position": {
              "x": 6,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                              "id": "${app_service_id}"
                          },
                          "name": "Http5xx",
                          "aggregationType": 7,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Http Server Errors",
                            "resourceDisplayName": "${app_service_name}"
                          }
                        }
                      ],
                      "title": "Count Http Server Errors for ${app_service_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "5": {
            "position": {
              "x": 0,
              "y": 8,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                              "id": "${db_server_id}"
                          },
                          "name": "storage_limit",
                          "aggregationType": 3,
                          "namespace": "microsoft.dbforpostgresql/servers",
                          "metricVisualization": {
                            "displayName": "Storage limit",
                            "resourceDisplayName": "${db_server_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                              "id": "${db_server_id}"
                          },
                          "name": "storage_used",
                          "aggregationType": 3,
                          "namespace": "microsoft.dbforpostgresql/servers",
                          "metricVisualization": {
                            "displayName": "Storage used",
                            "resourceDisplayName": "${db_server_name}"
                          }
                        }
                      ],
                      "title": "Max Storage limit and Max Storage used for ${db_server_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "6": {
            "position": {
              "x": 6,
              "y": 8,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                              "id": "${db_server_id}"
                          },
                          "name": "cpu_percent",
                          "aggregationType": 4,
                          "namespace": "microsoft.dbforpostgresql/servers",
                          "metricVisualization": {
                            "displayName": "CPU percent",
                            "resourceDisplayName": "${db_server_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                              "id": "${db_server_id}"
                          },
                          "name": "io_consumption_percent",
                          "aggregationType": 4,
                          "namespace": "microsoft.dbforpostgresql/servers",
                          "metricVisualization": {
                            "displayName": "IO percent",
                            "resourceDisplayName": "${db_server_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                              "id": "${db_server_id}"
                          },
                          "name": "pg_replica_log_delay_in_bytes",
                          "aggregationType": 3,
                          "namespace": "microsoft.dbforpostgresql/servers",
                          "metricVisualization": {
                            "displayName": "Max Lag Across Replicas",
                            "resourceDisplayName": "${db_server_name}"
                          }
                        }
                      ],
                      "title": "Avg CPU percent, Avg IO percent, and Max Max Lag Across Replicas for ${db_server_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-50487d1b-eb65-4500-ac98-4fc1a2214430",
                "StartboardPart-MonitorChartPart-50487d1b-eb65-4500-ac98-4fc1a2214630",
                "StartboardPart-MonitorChartPart-50487d1b-eb65-4500-ac98-4fc1a221463c",
                "StartboardPart-MonitorChartPart-50487d1b-eb65-4500-ac98-4fc1a2214648",
                "StartboardPart-UnboundPart-50487d1b-eb65-4500-ac98-4fc1a221449d"
              ]
            }
          }
        }
      }
    }
  }