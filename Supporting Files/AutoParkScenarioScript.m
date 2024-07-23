rrAppPath = "C:\Program Files\RoadRunner R2023b\bin\win64";
rrProjectPath = "C:\Users\varun\ME599\autopark\AutoPark";
s = settings;
s.roadrunner.application.InstallationFolder.TemporaryValue = rrAppPath;

% Open RoadRunner with path to project
rrApp = roadrunner(rrProjectPath);

% Open the desired scene and scenario from RR
openScene(rrApp, "ParkingGarage.rrscene");
openScenario(rrApp, "AutoPark.rrscenario");

% Create simulation object
rrSim = createSimulation(rrApp);

% Specifying the step size for RR scenario sim and Simulink to use
simStepSize = 0.1;
set(rrSim, "StepSize", simStepSize);

% Load bus object definitions
load(fullfile(matlabroot, 'toolbox', 'driving', 'drivingdata', 'rrScenarioSimTypes.mat'));

% Open Simulink file that describes behavior for actor in RoadRunner Scenario
model_name = "C:\Users\varun\ME599\autopark\Supporting Files\AutoParkFollowingBehaviour.slx";
open_system(model_name);
setScenarioVariable(rrApp,'SimulationTime_Time','100');
% Setting the maximum simulation time for 2000 seconds
simTime = 2000;  % 2000 seconds
set(rrSim, MaxSimulationTime=simTime);

% Start simulation in RR scenario
rrSim.set("SimulationCommand", "Start");

% Monitor simulation status
while strcmp(rrSim.get("SimulationStatus"), "Running")
    pause(1);
end
