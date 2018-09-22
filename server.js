const request = require("request");
const http = require("http");
const fs = require("fs");
const {
    execFile
} = require("child_process");
const {
    promisify
} = require("util");

const requestGetAsync = promisify(request.get);
const execFileAsync = promisify(execFile);
const ghHeaders = {
    Authorization: `token ${process.env.GITHUB_TOKEN}`,
    Accept: "application/vnd.github.v3+json",
    "User-Agent": "GH-Badge-Generator by @lap00zza"
};
// for im6 we will use a different generation script
const genScript = process.argv[2] && process.argv[2] === "--im6" ?
    "./gen_badge_im6.sh" :
    "./gen_badge.sh";

const reqHandler = (req, res) => {
    console.log(req.url)
    // @routeMatcher for '/for/{USERNAME}'
    if (req.url.match(/\/for\/([^\/]*)/)) {
        const ghUsername = req.url.split("/")[2];
        requestGetAsync({
            url: `https://api.github.com/users/${ghUsername}`,
            headers: ghHeaders,
            json: true /* very important */
        }).then(resp => {
            // NOTE: resp.body is json
            // TODO: handle errors
            console.log(resp.headers /* , resp.body */ );
            // fetch avatar
            console.time("avatar_downloaded_in");
            request.get(resp.body.avatar_url)
                .pipe(fs.createWriteStream(`./__cache__/gh_avatar_${resp.body.id}.png`))
                .on("finish", () => {
                    console.timeEnd("avatar_downloaded_in");
                    // Generate Badge
                    execFileAsync("sh", [
                        genScript,
                        resp.body.name,
                        resp.body.login,
                        resp.body.public_repos,
                        resp.body.public_gists,
                        resp.body.followers,
                        resp.body.id
                    ]).then(x => {
                        // TODO: handle errors
                        console.log(x);
                        // Send our badge
                        res.writeHead(200, {
                            "Content-Type": "image/png"
                        });
                        res.write(fs.readFileSync(`./__cache__/gh_badge_${resp.body.id}.png`));
                        res.end();
                    });
                });
        })
    }
    // catchAll 
    else {
        res.writeHead(200, {
            "Content-Type": "text/html"
        });
        res.write("You should be doing: <pre><code>GET /for/USERNAME</code></pre>");
        res.end();
    };
};

http.createServer(reqHandler).listen(process.env.PORT, () => {
    console.log(`GH Badge Generator is ready.`);
    console.log(`Listening on ${process.env.PORT}...`);
});

console.log(process.env.GITHUB_TOKEN);