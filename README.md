# xml2stemmarest

Simple bash script to build and upload collations to a [Stemmarest backend](https://github.com/unilenlac/tradition_repo). The script includes tools to normalize, tokenize texts, collate them via [Collatex](https://github.com/interedition/collatex), and import them into a Stemmarest backend.

The script can only handle TEI files that comply with the [TEI Manuscript Encoding Guidelines](https://tei-c.org/guidelines/customization/manuscript/) and the ENLAC DTD specification (see `testdata/` for examples and the `/utils/tei-irsb.dtd` file).

As it includes a docker-compose orchestration file, this repo can also be used to deploy a [Stemmaweb](https://github.com/unilenlac/stemmaweb) app and backend with a preloaded collation from a set of TEI files.

## Installation & Setup

The xml2collation.sh script is designed to be run inside a Docker container.

To run the script, you need to have **Docker** or **Podman** installed. You also need to have **Docker Compose** installed.

Then you need to clone this repository.

```
git clone https://github.com/unilenlac/xml2stemmarest.git
cd xml2stemmarest
```

Edit the `docker-compose.yml` file to set the `source` parameter to the path of the folder containing your TEI files. You can also use the default `corpus` folder included in the repository for testing purposes.

You also need to copy the `.env.example` file to `.env` and edit it to set the Stemmarest backend URL and the default user credentials.

Run the script with:

```
docker-compose up
```

The script can also be run as a standalone container, but you will need to use the `--build-arg MSS_PATH=your_path` argument when building the docker image to copy your own TEI files into the container.

One possible command to build the image is:

```
docker build --build-arg MSS_PATH=corpus -t enlac-pipeline enlac:jre8-alpine
```

You also must edit the `.env` file to set the Stemmarest backend URL and the default user credentials. You can use the provided `.env.example` file as a template.

### available parameters

- STEMMAREST_URL: the URL of the Stemmarest backend (default: http://stemmarest:8080/stemmarest/api)
- USER_ACCOUNT: the username of the default user (default: user)
- DEFAULT_USER_PASS: the password of the default user (default: userpass)
- COLLATEX_VERSION: the version of Collatex to use (default: collatex-tools-1.7.1.jar)
- MSS_PATH: the path to the folder containing your TEI files (default: corpus)


Files are copied to `/home/data` inside the container and output files are written to `/home/out`. You can access the container's shell to examine the output files or mount the output folder to your host machine.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or issues, please fill an issue or contact the project maintainer at renato.diaz@unil.ch.
