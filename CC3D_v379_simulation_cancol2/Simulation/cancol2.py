import sys
from os import environ
import CompuCellSetup
import CompuCell
import string
from os import getcwd

sys.path.append(environ["PYTHON_MODULE_PATH"])


import CompuCellSetup


sim,simthread = CompuCellSetup.getCoreSimulationObjects()
 
       
# add extra attributes here
        
CompuCellSetup.initializeSimulationObjects(sim,simthread)
# Definitions of additional Python-managed fields go here

pyAttributeAdder,dictAdder=CompuCellSetup.attachDictionaryToCells(sim)
        
#Add Python steppables here
steppableRegistry=CompuCellSetup.getSteppableRegistry()
 
OrientedGrowthPlugin = CompuCell.getOrientedGrowthPlugin()

from cancol2Steppables import CellLayoutSteppable
cellLayoutSteppable = CellLayoutSteppable(sim,_frequency=1)
steppableRegistry.registerSteppable(cellLayoutSteppable)

from cancol2Steppables import VolumeParamSteppable
volumeParamSteppable=VolumeParamSteppable(sim,_frequency=1)
steppableRegistry.registerSteppable(volumeParamSteppable)

from cancol2Steppables import MatrixDegradation
MDSteppable = MatrixDegradation(sim, _frequency=1)
steppableRegistry.registerSteppable(MDSteppable)

from cancol2Steppables import MitosisSteppable
mitosisSteppable=MitosisSteppable(sim,_frequency=1)
steppableRegistry.registerSteppable(mitosisSteppable)

from cancol2Steppables import CellMotilitySteppable
cellMotilitySteppable=CellMotilitySteppable(_simulator=sim,_frequency=1)
steppableRegistry.registerSteppable(cellMotilitySteppable)

from cancol2Steppables import SecretionSteppable
secretionSteppable=SecretionSteppable(_simulator=sim,_frequency=4)
steppableRegistry.registerSteppable(secretionSteppable)

from cancol2Steppables import OrientedConstraintSteppable
OrientedConstraintSteppableInstance=OrientedConstraintSteppable(sim,_frequency=1,_OGPlugin=OrientedGrowthPlugin)
steppableRegistry.registerSteppable(OrientedConstraintSteppableInstance)
        
CompuCellSetup.mainLoop(sim,simthread,steppableRegistry)
        
        