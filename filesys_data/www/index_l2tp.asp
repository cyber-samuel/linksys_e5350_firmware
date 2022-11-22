<tr>
<td><script>Capture(setupcontent.srvipaddr)</script></td>
<td>
<input type="hidden" name="l2tp_server_ip" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_0" value="<% get_single_ip("l2tp_server_ip","0"); %>" onBlur="valid_range(this,0,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_1" value="<% get_single_ip("l2tp_server_ip","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_2" value="<% get_single_ip("l2tp_server_ip","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_3" value="<% get_single_ip("l2tp_server_ip","3"); %>" onBlur="valid_range(this,0,254,'IP')" />
</td>
</tr>
<tr>
<td><script>Capture(share.usrname1)</script></td>
<td>
<input type="text" maxLength="63" size="26" name="ppp_username" value="<% nvram_get("ppp_username"); %>" onBlur="valid_name(this,'User%20Name')" />
</td>
</tr>
<tr>
<td><script>Capture(share.passwd)</script></td>
<td>
<input type="password" maxLength="63" size="26" name="ppp_passwd" value="<% nvram_invmatch("ppp_passwd","","d6nw5v1x2pc7st9m"); %>" onBlur="valid_name(this,'Password')" />
</td>
</tr>
<tr>
<td colspan="2">
<script>draw_radio('ppp_demand', '', '1', 'ppp_enable_disable(this.form,1)' <% nvram_match("ppp_demand_l2tp","1",", 0"); %>);</script>
<script>Capture(setupcontent.conndemand)</script>
<input type="text" class="num" maxLength="4" style="width:45px" name="ppp_idletime" value="<% nvram_get("ppp_idletime"); %>" onBlur="valid_range(this,1,9999,'Idle%20time')" />
<script>Capture(setupcontent.minute)</script>
</td>
</tr>
<tr>
<td colspan="2">
<script>draw_radio('ppp_demand', '', '0', 'ppp_enable_disable(this.form,0)' <% nvram_match("ppp_demand_l2tp","0",", 0"); %>);</script>
<script>Capture(setupcontent.keepalive)</script>
<input type="text" class="num" maxLength="4" style="width:45px" name="ppp_redialperiod" value="<% nvram_get("ppp_redialperiod"); %>" onBlur="valid_range(this,20,180,'Redial%20period')" />
<script>Capture(setupcontent.second)</script>
</td>
</tr>