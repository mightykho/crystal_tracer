# Crystal tracer

This is a very basic raytrace renderer written in Crystal for my talk "Computer Graphics for Ruby developers".

Please take into account that this project is not optimised in any way and only uses single process. 


## How to use

You can use already compiled binary
```
SCENE=./scene.json ./crystal_tracer
```

Or you can compile your own version:
```
shards install; crystal build src/crystal_tracer.cr --release;
```

Render output will be saved in `output.png` within projects root direcrtory.

![alt text](https://raw.githubusercontent.com/mightykho/crystal_tracer/master/output.png "Cornell box example")
