# Github Badge Generator
Show off your github profiles. Sample:

![Kyle Simpson](https://raw.githubusercontent.com/lap00zza/Github-Badge-Generator/master/__cache__/sample.png)

## Usage
You will need:
* NodeJS
* Imagemagick

Then run the following:
```sh
$ git clone https://github.com/lap00zza/Github-Badge-Generator.git
$ cd Github-Badge-Generator
$ npm install
$ chmod 700 *.sh
# if you have im6, run gen_base_im6.sh instead
$ ./gen_base.sh 
# if you have im6 add --im6 after server.js
$ GITHUB_KEY=xxx PORT=xxx node server.js
```

Once it is running open your browser and go to `localhost:PORT/for/GITHUB_USERNAME`

## License
[MIT License](/LICENSE)

Copyright (c) 2018 Jewel Mahanta
