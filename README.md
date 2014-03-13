# Al Haitham Project

The aim of this project is the proposal of a real time vision system for its application within visual interaction environments through hand gesture recognition using an FPGA and a camera.

## Features

- The project is based on the ALTERA DE2-115 FPGA kit and the TRDB-D5M camera.

- The current repository includes the hardware files only, software files can be found at [al-haitham software repo](https://github.com/aabdelfattah/alhaitham-software "alhaitham-software").

- Check pdf/project-doc.pdf for more technical details and block diagrams.

- The tracker detects :
  - pink colors and outputs their (x,y) locations , as a demo we used these locations to control the mouse pointer in Ubuntu .
  - pink + green as a left click.
  - green only as a right click.

- The results definitely need improvement (about ~0.5 fps) but it was basically a learning project and we wasted a lot of time messing with ALTERA glitchy tools, this project may act as a good base for others who want to quickly build up a working system and then start improving it.




## Install

Just clone the repo:

```
git clone https://github.com/aabdelfattah/alhaitham-hardware.git
```

1. Import the selected project from the repository to the local drive.

2. Open the project in Quartus II.

3. Open the SOPC builder project and build it.

4. Build the Quartus II project and program the hardware into the FPGA.

5. Import the software part(separate repository) of the project into a NIOS II IDE workplace.


That's it. Its ready to go.

## Run

Download the SOF to the DE2-115 , and run the software from NIOS II IDE .


## Contribute

- Fork project
- Add features
- Run tests
- Send pull request

## License

See LICENSE file for details