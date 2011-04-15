<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" validateRequest="false" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
     body
     {
      font:12px Arial,Helvetica,"Nimbus Sans L",sans-serif;
     	}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <fieldset>
         <legend> Authorization of LinkedIn </legend>
         <h3>Step 1.</h3>
         Before start this example api entegration, you must your api and secret key info to to web config. 
         you can change your LiApiKey and LiSecretKey values in the web.config<br />
         
         In this step : program will create an authorization link according to your apikey and secret info.
         and navigate to your user to linkedin login page (I created an example link, you should click this link for simulating the scenarion). 
         After that It will return again to this page with callback parameters.<i> (Meanwhile, you have to define 
         your callback page during registering your application on the LinkedIn.)</i> 
         <br /><br />You can use "oAuth Redirect parameter" in the "OAuth User Agreement"
         section of LinkedIn application definition page. 
         <strong>for example i used "http://localhost/LinkedInAuth/Default.aspx" </strong>
         <br />
         <h3>Step 2.</h3>
        <asp:Button ID="btnCreateAuthorization" Text="Create Authorization" 
            runat="server" onclick="btnCreateAuthorization_Click" />
            <br />
            <div style="border:solid 1px #ccc; background-color:#eee;">
            <table>
             <tr>
              <td>
              oAuth Request Token :
              </td>
              <td>
                 <asp:TextBox ID="txtRequestToken" runat="server" Width="300px"></asp:TextBox>              
              </td>
             </tr>
             <tr>
              <td>
                oAuth Request TokenSecret : 
              </td>
              <td>
                <asp:TextBox ID="txtTokenSecret" runat="server" Width="300px"></asp:TextBox>
              </td>
             </tr>
             <tr>
              <td>
                navigate to oauth page of LinkedIn :
              </td>
              <td>
                 <asp:HyperLink ID="hypAuthToken" runat="server"></asp:HyperLink>
              </td>
             </tr>
             
            </table>
            </div>
            <br />
              <h3>Step 3.</h3>
            <div style="border:solid 1px #ccc; background-color:#eee;">
                Now, we retrieved oauth_token and oauth_verifier, it's time to go access token from LinkedIn oAuth.<br />
            <table>
             <tr>
              <td>
              oauth_token:
              </td>
              <td>
                <asp:TextBox ID="txtoAuth_token" runat="server" Width="300px"></asp:TextBox>              
              </td>
             </tr>
             <tr>
              <td>
              oauth_verifier:
              </td>
              <td>
                <asp:TextBox ID="txtoAuth_verifier" runat="server"></asp:TextBox>             
              </td>
             </tr>

            </table>
                 
                <br />
                <asp:Button ID="btnGetAccessToken" runat="server" Text="Get Access Token" 
                    onclick="btnGetAccessToken_Click" />
                
            </div>
            
              <h3>Step 4.</h3>
            <div style="border:solid 1px #ccc; background-color:#eee;">
                Voila, We retrieved access token from Linked In. Thats it.<br />
                <table>
                 <tr>
                  <td>
                  oauth_Access_token:
                  </td>
                  <td>
                  <asp:TextBox ID="txtAccessToken" runat="server" Width="300px"></asp:TextBox>
                  </td>
                 </tr>
                 <tr>
                  <td>
                  oauth_Access_tokenSecret:
                  </td>
                  <td>
                   <asp:TextBox ID="txtAccessTokenSecret" runat="server" Width="300px"></asp:TextBox>
                  </td>
                 </tr>
                </table>
                                  
                <br />
                At this point you can make api calls with access_token and access_token_secret information
                according to linkedin documentation. (I created PUT and GET request examples)
            </div>            
            
              <h3>Step 5 Finally invoke LinkedIn Api.</h3>
            <div style="border:solid 1px #ccc; background-color:#eee;">
             Change my status to : <asp:TextBox ID="txtStatus" runat="server" Text="Let me test is it working ?" Width="250px"></asp:TextBox>
             <br />

             <asp:Button ID="btnSendStatusUpdate" runat="server" Text="Send Status Update (PUT Request Example)" 
                    onclick="btnSendStatusUpdate_Click" />
             <asp:Button ID="btnRequestProfile" runat="server" Text="Request User Profile (GET Request Example)" 
                    onclick="btnRequestProfile_Click" />
             <br/>
             
            <asp:TextBox id="txtApiResponse" ReadOnly="true" runat="server" TextMode="MultiLine" Rows="10" Width="650px"></asp:TextBox>        
            </div>
        </fieldset>
    </div>
    </form>
</body>
</html>
