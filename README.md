# C_project_scripts
Some bash scripts to automate C project initialisation.

---

### init_C_file.sh
This script creates a new c file with the name that you specify.  
To save you time the file will be initialised as below:  
```
#include <stdio.h>  
#include <stdlib.h>  

int main(int argc, char** argv) {  
  return 0;
}
```
Programme flags:
Ignore potential file overwrite warning: -i  
Display programme flags: -h or --help  

---

### init_C_project.sh
This script builds the foundation for a basic C project.  
**This script uses the same flags as `init_C_file.sh`**
You must specify how many files you want. Then you give each one a name. All of the files are  
initialised as above in `init_C_project.sh`, however, only the first file you give a name to  
will have the main function. This script also builds a basic Makefile. The Makefile will have  
an object file target for each file you add to the project.  
**Important things to consider when using this script:**
- You will still need to specify how the object files link together to form an executable. (in the makefile)
- The script does not build any header files. If you wish to add some, remember to include them in the Makefile.
