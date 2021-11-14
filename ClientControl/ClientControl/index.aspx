<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ClientControl.index" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <ul class="contact" style="font-size:x-large">
                <li class="icon solid fa-home"><h2>Inicio</h2></li>
            </ul>
        </header>
        <div class="features" >
            <img src="images/logo.jpg"/> 
           <%--<article>
				<span class="icon fa-gem"></span>
				<div class="content">
					<h3>Catálogos</h3>
					<p>Catálogo de clientes, lotes, manzanas, precios.</p>
				</div>
			</article>
			<article>
				<span class="icon solid fa-paper-plane"></span>
				<div class="content">
					<h3>Movimientos</h3>
					<p>Captura de pagos, generación de pagarés...</p>
				</div>
			</article>
			<article>
                <span class="icon solid fa-signal"></span>
				<div class="content">
					<h3>Reportes</h3>
					<p>Impresion de credenciales, contratos, estados de cuenta...</p>
				</div>
			</article>
			<article>
			    <span class="icon solid fa-rocket"></span>
				<div class="content">
					<h3></h3>
					<p>.</p>
				</div>
			</article>--%>
             <section>
                    <header class="major">
                        <h2>Contacto</h2>
                    </header>
                    <p style="text-align:justify;font-size:small">Campestre Concordia, es un desarrollo habitacional comprometido con el cuidado y respeto a la naturaleza, que cuenta con uno de los mejores planes de crecimiento en la región
para los próximos 10 años. Cuenta con una dimensión de 665 hectáreas y te ofrece la oportunidad de adquirir un terreno campestre que forme parte de tu patrimonio, alejado del bullicio de la ciudad,
con una gran calidad de vida y esparcimiento para sus colonos y visitantes, en donde la familia puede descansar de la rutina diaria y con el beneficio que ofrece el poseer un bien inmueble.</p>
                    <ul class="contact" style="font-size:small">
                        <li class="icon solid fa-envelope"><a href="mailto:ventas@campestreconcordia.com">ventas@campestreconcordia.com</a></li>
                        <li class="icon solid fa-phone">01 (664) 255 8541</li>
                        <li class="icon solid fa-home">Camino Vecinal El Hongo-Ojos Negros<br/>
                            Tecate, BC</li>
                    </ul>
                </section>
        </div>
    </section>
</asp:Content>
