FasdUAS 1.101.10   ��   ��    k             l      ��  ��   2,"Albumize Selection" for iTuneswritten by Doug Adamsdougscripts@mac.comv2.0 sept 4, 2010
-- universal binary
-- code finesses
v1.3 june 21, 2004-- fixes error with "p" variable

v1.2 jun 9 04
- updated from iTunes 2 era

v1.0 nov 22 01
- initial release
Get more free AppleScripts and info on writing your ownat Doug's AppleScripts for iTunesdougscripts.comThis program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

     � 	 	X  " A l b u m i z e   S e l e c t i o n "   f o r   i T u n e s  w r i t t e n   b y   D o u g   A d a m s  d o u g s c r i p t s @ m a c . c o m   v 2 . 0   s e p t   4 ,   2 0 1 0 
 - -   u n i v e r s a l   b i n a r y 
 - -   c o d e   f i n e s s e s 
  v 1 . 3   j u n e   2 1 ,   2 0 0 4  - -   f i x e s   e r r o r   w i t h   " p "   v a r i a b l e 
 
 v 1 . 2   j u n   9   0 4 
 -   u p d a t e d   f r o m   i T u n e s   2   e r a 
 
 v 1 . 0   n o v   2 2   0 1 
 -   i n i t i a l   r e l e a s e 
   G e t   m o r e   f r e e   A p p l e S c r i p t s   a n d   i n f o   o n   w r i t i n g   y o u r   o w n  a t   D o u g ' s   A p p l e S c r i p t s   f o r   i T u n e s  d o u g s c r i p t s . c o m   T h i s   p r o g r a m   i s   f r e e   s o f t w a r e   r e l e a s e d   " a s - i s " ;   y o u   c a n   r e d i s t r i b u t e   i t   a n d / o r   m o d i f y   i t   u n d e r   t h e   t e r m s   o f   t h e   G N U   G e n e r a l   P u b l i c   L i c e n s e   a s   p u b l i s h e d   b y   t h e   F r e e   S o f t w a r e   F o u n d a t i o n ;   e i t h e r   v e r s i o n   2   o f   t h e   L i c e n s e ,   o r   ( a t   y o u r   o p t i o n )   a n y   l a t e r   v e r s i o n . 
 
 T h i s   p r o g r a m   i s   d i s t r i b u t e d   i n   t h e   h o p e   t h a t   i t   w i l l   b e   u s e f u l ,   b u t   W I T H O U T   A N Y   W A R R A N T Y ;   w i t h o u t   e v e n   t h e   i m p l i e d   w a r r a n t y   o f   M E R C H A N T A B I L I T Y   o r   F I T N E S S   F O R   A   P A R T I C U L A R   P U R P O S E .     S e e   t h e   G N U   G e n e r a l   P u b l i c   L i c e n s e   f o r   m o r e   d e t a i l s . 
 
 G e t   a   c o p y   o f   t h e   G N U   G e n e r a l   P u b l i c   L i c e n s e   b y   w r i t i n g   t o   t h e   F r e e   S o f t w a r e   F o u n d a t i o n ,   I n c . ,   5 1   F r a n k l i n   S t r e e t ,   F i f t h   F l o o r ,   B o s t o n ,   M A     0 2 1 1 0 - 1 3 0 1 ,   U S A . 
 
 o r   v i s i t   h t t p : / / w w w . g n u . o r g / c o p y l e f t / g p l . h t m l 
 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��        j     �� �� 0 my_title    m        �   $ A l b u m i z e   S e l e c t i o n      j    �� �� 0 mybutton myButton  m       �    O K   +   A l b u m      l     ��������  ��  ��        l   U ����  O    U     Z   T ! "�� # ! =    $ % $ n     & ' & 1   
 ��
�� 
pShf ' n    
 ( ) ( 1    
��
�� 
pPly ) 4   �� *
�� 
cwin * m    ����  % m    ��
�� boovfals " k   ( + +  , - , r     . / . 1    ��
�� 
sele / o      ���� 0 p   -  0�� 0 Z   ( 1 2�� 3 1 >    4 5 4 o    ���� 0 p   5 J    ����   2 k    � 6 6  7 8 7 r    ' 9 : 9 I   %�� ;��
�� .corecnte****       **** ; n   ! < = < 2   !��
�� 
cobj = o    ���� 0 p  ��   : o      ���� 0 c   8  > ? > l  ( (��������  ��  ��   ?  @ A @ r   ( p B C B I  ( l�� D E
�� .sysodlogaskr        TEXT D b   ( 7 F G F b   ( 5 H I H b   ( / J K J b   ( - L M L b   ( + N O N m   ( ) P P � Q Q � S e l e c t i n g   " O K "   s e t s   t h e   T r a c k   N u m b e r s   o f   t h e   s e l e c t e d   t r a c k s   t o   t h e i r   c u r r e n t   P l a y   O r d e r . O o   ) *��
�� 
ret  M o   + ,��
�� 
ret  K m   - . R R � S S  S e l e c t i n g   " I o   / 4���� 0 mybutton myButton G m   5 6 T T � U U � "   a l s o   c h a n g e s   e a c h   T r a c k ' s   A l b u m   N a m e   t o   t h e   o n e   e n t e r e d   b e l o w : E �� V W
�� 
dtxt V l  8 @ X���� X e   8 @ Y Y c   8 @ Z [ Z n   8 > \ ] \ 1   < >��
�� 
pAlb ] n   8 < ^ _ ^ 4   9 <�� `
�� 
cobj ` m   : ;����  _ o   8 9���� 0 p   [ m   > ?��
�� 
ctxt��  ��   W �� a b
�� 
btns a J   C P c c  d e d m   C F f f � g g  C a n c e l e  h i h m   F I j j � k k  O K i  l�� l o   I N���� 0 mybutton myButton��   b �� m n
�� 
dflt m m   S T����  n �� o p
�� 
appr o o   W \���� 0 my_title   p �� q r
�� 
disp q m   _ `����  r �� s��
�� 
givu s m   c f���� ���   C o      ���� 0 a   A  t u t l  q q��������  ��  ��   u  v w v l  q q��������  ��  ��   w  x y x r   q z z { z 1   q v��
�� 
pFix { o      ���� 0 ofi   y  | } | r   { � ~  ~ m   { |��
�� boovtrue  1   | ���
�� 
pFix }  � � � Y   � � ��� � ��� � k   � � � �  � � � r   � � � � � n   � � � � � 4   � ��� �
�� 
cobj � o   � ����� 0 i   � o   � ����� 0 p   � o      ���� 0 t   �  � � � Q   � � � ��� � k   � � � �  � � � r   � � � � � o   � ����� 0 i   � l      ����� � n       � � � 1   � ���
�� 
pTrN � o   � ����� 0 t  ��  ��   �  ��� � r   � � � � � o   � ����� 0 c   � l      ����� � n       � � � 1   � ���
�� 
pTrC � o   � ����� 0 t  ��  ��  ��   � R      ������
�� .ascrerr ****      � ****��  ��  ��   �  ��� � Q   � � � ��� � t   � � � � � Z  � � � ����� � =  � � � � � n   � � � � � 1   � ���
�� 
bhit � o   � ����� 0 a   � o   � ����� 0 mybutton myButton � r   � � � � � n   � � � � � 1   � ���
�� 
ttxt � o   � ����� 0 a   � n       � � � 1   � ���
�� 
pAlb � n   � � � � � 4   � ��� �
�� 
cTrk � o   � ����� 0 i   � o   � ����� 0 p  ��  ��   � m   � �����  � R      ������
�� .ascrerr ****      � ****��  ��  ��  ��  �� 0 i   � m   � �����  � o   � ����� 0 c  ��   �  � � � r   � � � � � o   � ����� 0 ofi   � 1   � ���
�� 
pFix �  ��� � l  � ���������  ��  ��  ��  ��   3 I  �(�� � �
�� .sysodlogaskr        TEXT � l  � ����� � b   � � � � o   � ��
�� 
ret  � m    � � � � � : N o   t r a c k s   h a v e   b e e n   s e l e c t e d .��  ��   � �� � �
�� 
btns � J   � �  ��� � m  
 � � � � �  O h��   � �� � �
�� 
dflt � m  ����  � �� � �
�� 
appr � o  �� 0 my_title   � �~ � �
�~ 
disp � m  �}�}   � �| ��{
�| 
givu � m  "�z�z �{  ��  ��   # I +T�y � �
�y .sysodlogaskr        TEXT � l +0 ��x�w � b  +0 � � � o  +,�v
�v 
ret  � m  ,/ � � � � � � S h u f f l e   m u s t   b e   o f f ,   o t h e r w i s e   y o u r   s e l e c t e d   t r a c k s   m a y   n o t   b e   i n   t h e   c o r r e c t   o r d e r .�x  �w   � �u � �
�u 
btns � J  38 � �  ��t � m  36 � � � � �  O h�t   � �s � �
�s 
dflt � m  ;<�r�r  � �q � �
�q 
appr � o  ?D�p�p 0 my_title   � �o � �
�o 
disp � m  GH�n�n   � �m ��l
�m 
givu � m  KN�k�k �l     m      � ��                                                                                  hook  alis    2  Mac                        Ȓ_H+    3
iTunes.app                                                      �Ɓi�        ����  	                Applications    ȑ�?      ƁM�      3  Mac:Applications:iTunes.app    
 i T u n e s . a p p    M a c  Applications/iTunes.app   / ��  ��  ��     ��j � l     �i�h�g�i  �h  �g  �j       �f �   ��f   � �e�d�c�e 0 my_title  �d 0 mybutton myButton
�c .aevtoappnull  �   � **** � �b ��a�` � ��_
�b .aevtoappnull  �   � **** � k    U � �  �^�^  �a  �`   � �]�] 0 i   � + ��\�[�Z�Y�X�W�V�U P�T R T�S�R�Q�P f j�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�= � ��< � �
�\ 
cwin
�[ 
pPly
�Z 
pShf
�Y 
sele�X 0 p  
�W 
cobj
�V .corecnte****       ****�U 0 c  
�T 
ret 
�S 
dtxt
�R 
pAlb
�Q 
ctxt
�P 
btns
�O 
dflt
�N 
appr
�M 
disp
�L 
givu�K ��J 
�I .sysodlogaskr        TEXT�H 0 a  
�G 
pFix�F 0 ofi  �E 0 t  
�D 
pTrN
�C 
pTrC�B  �A  �@ 
�? 
bhit
�> 
ttxt
�= 
cTrk�< 
�_V�R*�k/�,�,f *�,E�O�jv ���-j E�O��%�%�%b  %�%���k/�,�&a a a b  mva la b   a la a a  E` O*a ,E` Oe*a ,FO lk�kh  ��/E` O �_ a ,FO�_ a ,FW X   !hO .a "n_ a #,b    _ a $,�a %�/�,FY hoW X   !h[OY��O_ *a ,FOPY +�a &%a a 'kva ka b   a ja a "a ( Y +�a )%a a *kva ka b   a ja a "a ( U ascr  ��ޭ