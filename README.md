# satelliteDigitalTwin
<Español>

Desarrollado para Azure Digital Twins utilizando JSON y Bash.

Este repositorio contiene el código utilizado en el trabajo de fin de máster de ingeniería de telecomunicaciones de la Universitat Oberta de Catalunya "Gemelo Digital del Satélite Galileo". El repositorio se organiza en tres secciones principales:

1. Carpeta "Models": Esta carpeta incluye los modelos en DTLD de los 21 nodos utilizados para desarrollar el gemelo digital. Estos modelos pueden implementarse de forma individual en el "Azure Digital Twin Explorer", aunque es más eficiente utilizar el archivo principal del proyecto, "satellite.json". Este archivo define todos los modelos, incluyendo sus propiedades y relaciones. Para su uso, simplemente debemos importarlo utilizando la opción "Import Graph" dentro del "Azure Digital Twin Explorer". Una vez importado, generamos todos los gemelos ejecutando la consulta por defecto presionando "Run Query", obteniendo así el gráfico final:

![image](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/93f64d30-a44b-4754-a3b7-4db696da5f91)

2. Carpeta "SendData": Dado que se trata de un caso teórico y que se deben generar más de 35 datos para alimentar el modelo en cada interacción, se ha utilizado el archivo "send.bash" ubicado en esta carpeta. Este archivo define la generación aleatoria de datos basándose en el esquema de datos diseñado:

![Estructura de gemelos](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/a84a8a9b-f4ca-4bb2-8535-afd509f44de8)

3. Modelo 3D del Satélite: Con el gemelo definido y alimentado con datos, podemos proceder a cargar el modelo 3D del satélite. Para este caso, el estudio se ha basado en uno de los satélites Galileo de la ESA (European Space Agency). El modelo 3D puede descargarse desde la página oficial de la ESA (https://gssc.esa.int/education/galileo3d/) y renderizarse para subirlo a la plataforma de Azure como un archivo ".glb". Una vez hecho esto, podemos vincular los datos con el modelo 3D en la sección "3DScenes" dentro del mismo "Azure Digital Twin Explorer", concluyendo así el proceso:

![sat v final sin nombre](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/9922fd4f-2039-4076-a1b0-464c5747a5f3)


<English>

Developed for Azure Digital Twins using JSON and Bash.

This repository contains the code used in the Universitat Oberta de Catalunya's Master's thesis "Digital Twin of the Galileo Satellite". The repository is organised in three main sections:

1. "Models" folder: This folder includes the DTLD models of the 21 nodes used to develop the digital twin. These models can be implemented individually in the "Azure Digital Twin Explorer", although it is more efficient to use the main project file, "satellite.json". This file defines all models, including their properties and relationships. To use it, we simply import it using the "Import Graph" option in Azure Digital Twin Explorer. Once imported, we generate all the twins by executing the default query by pressing "Run Query", thus obtaining the final graph:

![image](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/93f64d30-a44b-4754-a3b7-4db696da5f91)

2. "SendData" folder: Since this is a theoretical case and more than 35 data must be generated to feed the model in each interaction, the file "send.bash" located in this folder has been used. This file defines the random generation of data based on the designed data schema:

![Estructura de gemelos](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/a84a8a9b-f4ca-4bb2-8535-afd509f44de8)

3. 3D Satellite Model: With the twin defined and fed with data, we can proceed to load the 3D model of the satellite. In this case, the study is based on one of the ESA (European Space Agency) Galileo satellites. The 3D model can be downloaded from the official ESA website (https://gssc.esa.int/education/galileo3d/) and rendered and uploaded to the Azure platform as a ".glb" file. Once this is done, we can link the data with the 3D model in the "3DScenes" section within the same "Azure Digital Twin Explorer", thus concluding the process:

![sat v final sin nombre](https://github.com/jgcreus/satelliteDigitalTwin/assets/61203608/9922fd4f-2039-4076-a1b0-464c5747a5f3)
