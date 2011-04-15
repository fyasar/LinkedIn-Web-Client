using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class _Default : System.Web.UI.Page 
{
    private oAuthLinkedIn _oauth = new oAuthLinkedIn();
    protected void Page_Load(object sender, EventArgs e)
    {
        string oauth_token = Request.QueryString["oauth_token"];
        string oauth_verifier = Request.QueryString["oauth_verifier"];
        if (oauth_token != null && oauth_verifier != null)
        {
            txtRequestToken.Text = Application["reuqestToken"].ToString();
            txtTokenSecret.Text = Application["reuqestTokenSecret"].ToString();
            hypAuthToken.NavigateUrl = Application["oauthLink"].ToString();
            hypAuthToken.Text = Application["oauthLink"].ToString();

            Application["oauth_token"] = oauth_token;
            Application["oauth_verifier"] = oauth_verifier;

            txtoAuth_token.Text  = oauth_token;
            txtoAuth_verifier.Text = oauth_verifier;
        }
    }

    protected void btnCreateAuthorization_Click(object sender, EventArgs e)
    {
        string authLink = _oauth.AuthorizationLinkGet();
        Application["reuqestToken"] = _oauth.Token;
        Application["reuqestTokenSecret"] = _oauth.TokenSecret;
        Application["oauthLink"] = authLink;

        txtRequestToken.Text = _oauth.Token;
        txtTokenSecret.Text = _oauth.TokenSecret;
        hypAuthToken.NavigateUrl = authLink;
        hypAuthToken.Text = authLink;
    }

    protected void btnGetAccessToken_Click(object sender, EventArgs e)
    {
        _oauth.Token = txtoAuth_token.Text;
        _oauth.TokenSecret = txtTokenSecret.Text;
        _oauth.Verifier = txtoAuth_verifier.Text;

        _oauth.AccessTokenGet(txtoAuth_token.Text);
        txtAccessToken.Text = _oauth.Token;
        txtAccessTokenSecret.Text = _oauth.TokenSecret;
        btnGetAccessToken.Focus();
    }

    protected void btnSendStatusUpdate_Click(object sender, EventArgs e)
    {
        _oauth.Token = txtAccessToken.Text;
        _oauth.TokenSecret = txtAccessTokenSecret.Text;
        _oauth.Verifier = txtoAuth_verifier.Text;

            string xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
                   xml += "<current-status>It's really working .</current-status>";

             string response = _oauth.APIWebRequest("PUT", "http://api.linkedin.com/v1/people/~/current-status", xml);
             if (response == "")
                 txtApiResponse.Text = "Your new status updated";
             btnSendStatusUpdate.Focus();
    }


    protected void btnRequestProfile_Click(object sender, EventArgs e)
    {
        _oauth.Token = txtAccessToken.Text;
        _oauth.TokenSecret = txtAccessTokenSecret.Text;
        _oauth.Verifier = txtoAuth_verifier.Text;

        string response = _oauth.APIWebRequest("GET", "https://api.linkedin.com/v1/people/~", null);
        txtApiResponse.Text = response;
        btnRequestProfile.Focus();
    }
}
