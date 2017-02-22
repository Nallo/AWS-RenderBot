# RenderBot

RenderBot is a bash script that connects to an EC2 instance with Blender
and perform render using GPU.

1. Copy your .pem file in the RenderBot root folder
1. Copy your .blend file in the RenderBot root folder. Be sure to have the Blender
   _experimental_ features enabled.
1. You are ready to go!

```bash
#### Start rendering

bash start_render.sh ec2.public.dns.com file.blend
```

## How It Works

RenderBot will connect to a running EC2 instance, it will create a temporary folder
to the user home folder, it will update the .blend file and will start the render.

When the render has done, RenderBot will download the .jpg file to its folder and it will
call it **output0001.jpg**.
