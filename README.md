## Managment

Each service has it's own _control.sh script which specifies how to start, stop, restart and update service.  
All services are managed by control.sh in main directory which in turns calls _control.sh scripts.

## Adding new services

To add new service, create new directory with _control.sh in it.  
Every _control.sh has to implement these functions:
- start
- stop
- update
